# main.rb controls all the other Ruby files in TutorHub

require 'sinatra'
require 'csv'
require 'zip'
require 'bcrypt'
require_relative 'user'

# Comment this line out to keep database entries from last run
User.auto_migrate!

configure do
  enable :sessions
end

get '/' do
  session.clear
  #display login page
  erb :login
end

get '/login' do
  username = params[:username]
  password = params[:password]
  @user = User.get(username)
  if @user
    session[:username] = username
    session[:password] = BCrypt::Password.new(@user.password)
    if session[:password] == password
      redirect to('/home')
    else
      redirect to('/invalid-login')
    end
  else
    session.clear
    redirect to('/invalid-login')
  end
end

get '/create-account' do
  erb :createAccount
end

get '/new-account' do
  username = params[:username]
  @currusername = username
  password = params[:password]
  major = params[:major]
  about = params[:about]
  @user = User.get(username)
  if @user #if username already being used
    redirect to ('/invalid-username')
  else #add to database, go to homepage
    new = User.new username: username, password: BCrypt::Password.create(password), major: major, about: about
    new.save
    redirect to ('/home')
  end
end

get '/invalid-login' do
  erb :invalidLogin
end

get '/invalid-username' do
  #TODO: fill with previous parameters
  erb :invalidUsername
end

get '/home' do
  erb :home
end