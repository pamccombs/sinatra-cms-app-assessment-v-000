class LipsticksController < ApplicationController

  get '/lipsticks' do
    redirect_if_not_logged_in
    @users = User.all
    erb :'lipsticks/lipsticks'
  end

  get '/lipsticks/new' do
    redirect_if_not_logged_in
    erb :'lipsticks/new'
  end

  post '/lipsticks' do
    redirect_if_not_logged_in
    if params[:color_scheme_main] == ""
      redirect '/lipsticks/new'
    else
    #@lipstick = Lipstick.create(
    #  color_scheme_main: params[:color_scheme_main],
    #  color_scheme_undertone: params[:color_scheme_undertone],
    #  name_of_lipstick: params[:name_of_lipstick],
    #  finish: params[:finish],
    #  dryness: params[:dryness],
    #  requires_a_base: params[:requires_a_base],
    #  longevity: params[:longevity],
    #  brand: params[:brand],
    #  difficulty_to_apply: params[:difficulty_to_apply],
    #  difficulty_to_remove: params[:difficulty_to_remove],
    #  oil_or_water_removal: params[:oil_or_water_removal]
    #  )
    @lipstick = current_user.lipsitcks.build(params)
    @lipstick.save
    redirect "/lipsticks/#{@lipstick.id}"
    end
  end

  get '/lipsticks/:id' do
    redirect_if_not_logged_in
    @lipstick = Lipstick.find_by_id(params[:id])
    erb :'lipsticks/show_lipstick'
  end

  get '/lipsticks/:id/edit' do
    @lipstick = Lipstick.find_by_id(params[:id])

    if logged_in? && @lipstick.user_id == session[:user_id]
      erb :'lipsticks/edit_lipstick'
    else
      redirect to "/lipsticks"
    end
  end

  patch '/lipsticks/:id' do
    redirect_if_not_logged_in
    if params[:color_scheme_main] == ""
        redirect "/lipsticks/#{params[:id]}/edit"
    else
      @lipstick = Lipstick.find_by_id(params[:id])
      if @lipstick && @lipstick.user == current_user
        if @lipstick.update(
          color_scheme_main: params[:color_scheme_main],
          color_scheme_undertone: params[:color_scheme_undertone],
          name_of_lipstick: params[:name_of_lipstick],
          finish: params[:finish],
          dryness: params[:dryness],
          requires_a_base: params[:requires_a_base],
          longevity: params[:longevity],
          brand: params[:brand],
          difficulty_to_apply: params[:difficulty_to_apply],
          difficulty_to_remove: params[:difficulty_to_remove],
          oil_or_water_removal: params[:oil_or_water_removal]
          )
          redirect "/lipsticks/#{@lipstick.id}"
        else
        redirect "/lipsticks/#{@lipstick.id}/edit"
        end
      else
        redirect '/lipsticks'
      end
    end
  end

  delete '/lipsticks/:id/delete' do
    @lipstick = Lipstick.find_by_id(params[:id])

    if logged_in? && @lipstick.user_id == session[:user_id]
      @lipstick.delete
      redirect '/lipsticks'
    else
      redirect '/login'
    end
  end

end
