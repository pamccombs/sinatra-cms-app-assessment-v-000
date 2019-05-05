require 'rack-flash'
 # require 'flash'
class UsersController < ApplicationController
  
  get '/login' do
    if logged_in?
      redirect '/lipsticks'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
      @user = User.find_by(:username => params[:username])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id

        redirect '/lipsticks'
      else
        redirect '/signup'
      end
    end

    get '/users/:slug' do
      @user = User.find_by(params[:user_id])
      erb :'users/show'
    end

    get '/signup' do
      if logged_in?
        redirect '/lipsticks'
      else
        erb :'users/create_user'
        # flash[:message] = "Welcome to YourLip!"
      end
    end


    post '/signup' do
      @user = User.new(params)
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect  '/signup'
      elsif
        @user.save 
    	    session[:user_id] = @user.id
      redirect to "/lipsticks"
      
      elsif @user.errors
      redirect to "/signup"
      
      else
      redirect to "/signup"
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