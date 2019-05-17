class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect '/lipsticks'
    else
      erb :'users/create_user'
    end
  end


  post '/signup' do
    @user = User.new(params)
    
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect  '/signup'
    elsif @user.save
  	  session[:user_id] = @user.id
      redirect to "/lipsticks"
    else
      redirect to "/signup"
    end
  end
    
  get '/login' do
    if logged_in?
      redirect '/lipsticks'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(:email => params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/lipsticks'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if !logged_in?
      redirect to "/"
    else
      session.clear
      redirect to "/"
    end
  end
  
end