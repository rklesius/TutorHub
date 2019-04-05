# main.rb controls all the other Ruby files in TutorHub

require 'sinatra'
require 'csv'
require 'zip'
require 'bcrypt'
require_relative 'user'
require_relative 'help'

# Comment this line out to keep database entries from last run
#User.auto_migrate!
Help.auto_migrate!

currhelpid = 1
currlessonid = 1

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
  password = params[:password]
  name = params[:name]
  major = params[:major]
  about = params[:about]
  @user = User.get(username)
  if @user #if username already being used
    redirect to ('/invalid-username')
  else #add to database, go to homepage
    new = User.new username: username, password: BCrypt::Password.create(password), name: name, major: major, about: about
    new.save
    session[:username] = username
    redirect to ('/home')
  end
end

get '/invalid-login' do
  erb :invalidLogin
end

get '/invalid-username' do
  erb :invalidUsername
end

#display all lessons
get '/home' do
  erb :home
end

get '/logout' do
  session.clear
  redirect to ('/')
end

#display individual lesson
get '/lessons/:lid' do
  erb :viewlesson
end

#redirect to erb to create new lesson
get '/new-lesson' do
  erb :newlesson
end

#create new lesson after form submission from '/new-lesson'
get '/create-lesson' do
  #TODO: Form submission
end

#display all help
get '/help' do
  erb :help
end

#display individual help
get '/help/:hid' do
  @view_help = Help.get(params[:hid])
  erb :viewhelp
end

#redirect to erb to create new help
get '/new-help' do
  erb :newhelp
end

#create new help after form submission from '/new-help'
get '/create-help' do
  title = params[:title]
  description = params[:description]
  category = params[:category]
  newhelp = Help.new helpid: currhelpid, title: title, description: description, category: category, username: session[:username]
  newhelp.save
  currhelpid = currhelpid + 1
  redirect to ('/help')
end

get '/user/:username' do
  @view_user = User.get(params[:username])
  erb :profile
end