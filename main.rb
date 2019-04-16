# main.rb controls all the other Ruby files in TutorHub

require 'sinatra'
require 'csv'
require 'zip'
require 'bcrypt'
require_relative 'user'
require_relative 'help'
require_relative 'lessons'
require_relative 'comment'

# Comment this line out to keep database entries from last run, need to run these to init tables!!!
#User.auto_migrate!
#Help.auto_migrate!
#Lesson.auto_migrate!
#Comment.auto_migrate!

postid = 1
commentid = 1

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
  @view_lesson = Lesson.get(params[:lid])
  erb :viewlesson
end

#redirect to erb to create new lesson
get '/new-lesson' do
  erb :newlesson
end

#create new lesson after form submission from '/new-lesson'
get '/create-lesson' do
  title = params[:title]
  description = params[:description]
  category = params[:category]
  date = params[:date]
  location = params[:location]
  newlesson = Lesson.new lessonid: postid, title: title, description: description, category: category, username: session[:username],
                         date: date, location: location, resolved: FALSE
  newlesson.save
  postid = postid + 1
  redirect to ('/home')
end

get '/lesson-complete/:lid' do
  lesson = Lesson.get(params[:lid])
  lesson.update(:resolved => TRUE)
  redirect to ('/home')
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
  newhelp = Help.new helpid: postid, title: title, description: description, category: category, username: session[:username], resolved: FALSE
  newhelp.save
  postid = postid + 1
  redirect to ('/help')
end

#mark help as resolved
get '/help-resolved/:hid' do
  help = Help.get(params[:hid])
  help.update(:resolved => TRUE)
  redirect to ('/help')
end

#add a comment with a corresponding post id
get '/add-comment/:pid' do
  description = params[:description]
  comment = Comment.new commentid: commentid, postid: params[:pid], username: session[:username],  description: description
  comment.save
  commentid = commentid + 1

  #redirect to where you were
  if Help.get(params[:pid])
    redirect to ('help/' + params[:pid])
  else
    redirect to ('lessons/' + params[:pid])
  end
end

get '/user/:username' do
  @view_user = User.get(params[:username])
  erb :profile
end

# if page not found
not_found do
  status 404
  erb :error
end