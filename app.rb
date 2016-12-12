require 'sinatra'
require_relative 'config/application'
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces


helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  session[:user_username] = user.username
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all.order(:name)
  @current_user = User.find_by(id: session[:user_id])
  erb :'meetups/index'
end

post '/meetups/new' do
  session[:new_meetup]= Meetup.create({
    name: params[:name],
    description: params[:description],
    date: params[:date],
    time: params[:time],
    creator: session[:user_username],
    location: params[:location]
    })

    if session[:new_meetup].valid?
      flash[:congrats] = "Congrats! You successfuly created a new meetup"
      redirect "meetups/#{session[:new_meetup].id}"
    else
      flash[:error] = "#{session[:new_meetup].errors.full_messages}"
      redirect '/meetups/new'
    end
end

get '/meetups/new' do
  erb :'/meetups/new'
end


get '/meetups/:id' do
  @meetup = Meetup.find(params[:id])
  session[:meetup_id] = params[:id]
  @users = @meetup.users
  @creator = @meetup.creator
  session[:current_meetup] = @meetup.id
  erb :'meetups/show'
end

post '/join_meetup' do
  if session[:user_id].nil?
    flash[:sign_in] = "Please sign in to join a meetup"
    redirect "/meetups/#{session[:current_meetup]}"
  end
  binding.pry
  session[:new_meetup_user] = UsersAndMeetup.create({
    user_id: session[:user_id],
    meetup_id: session[:meetup_id]
  })

  if session[:new_meetup_user]
    flash[:joined] = "Congrats! you joined this meetup"
    redirect "/meetups/#{session[:current_meetup]}"
  end

end

post '/meetups/edit/:id' do
  session[:edited_meetup].update({
    name: params[:name],
    description: params[:description],
    date: params[:date],
    time: params[:time],
    creator: session[:user_username],
    location: params[:location]
    })

    if session[:edited_meetup].valid?
      flash[:edit] = "Congrats! You successfuly edited this meetup"
      redirect "/meetups/#{session[:edited_meetup].id}"
    else
      flash[:error_edit] = "#{session[:edited_meetup].errors.full_messages}"
      redirect "/meetups/edit/#{session[:edited_meetup].id}"
    end
end

get '/meetups/edit/:id' do
  @meetup_to_edit = Meetup.find(params[:id])
  session[:edited_meetup] = @meetup_to_edit

  erb :'/meetups/edit'
end

post '/leave_meetup' do
  @user_of_meetup = Meetup.find(session[:current_meetup])
  @user_of_meetup.users.delete(User.find(current_user.id))
  flash[:leave_meetup] = "You left this meetup"

  redirect "/meetups/#{session[:current_meetup]}"
end

post '/delete_meetup' do
  @current_meetup = Meetup.find(session[:current_meetup])
  @current_meetup.delete

  redirect "/"
end

# post '/join_this_meetup' do
#   if session[:user_id].nil?
#     flash[:sign_in] = "Please sign in to join a meetup"
#     redirect "/meetups/#{session[:current_meetup]}"
#   end
#
#   session[:new_meetup_user] = UsersAndMeetup.create({
#     user_id: session[:user_id],
#     meetup_id: session[:current_meetup]
#   })
#
# end
