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
      redirect to('/')
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
  password = params[:password]
  major = params[:major]
  about = params[:about]
  @user = User.get(username)
  if @user #if username already being used
    session.clear
    redirect to ('/invalid-username')
  end
end

get '/invalid-login' do
  #TODO: make erb with login page but with error message
end

get '/invalid-username' do
  #TODO: make erb with create account but with error message
  #TODO: fill with previous parameters
end

