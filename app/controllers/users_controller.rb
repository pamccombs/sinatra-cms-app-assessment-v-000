require 'rack-flash'
 # require 'flash'
class UsersController < ApplicationController

    get '/users/:slug' do
      @user = User.find_by(params[:slug])
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
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect  '/signup'
      else
        @user = User.new(username: params["username"], email: params["email"], password: params["password"])
        @user.save
        session[:user_id] = @user.id
          redirect '/lipsticks'
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
      @user = User.find_by(:username => params[:username])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id

        redirect '/lipsticks'
      else
        redirect '/signup'
      end
    end


    get '/logout' do
      if logged_in?
        session.destroy

        redirect '/login'
      else
        redirect '/'
      end
    end
end