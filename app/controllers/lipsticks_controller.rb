class LipsticksController <ApplicationController

  get '/lipsticks' do
    if logged_in?
      @users = User.all
      #@users each do |user|
        #user.lipsticks each |lipstick| do
      erb :'lipsticks/lipsticks'
    else
      redirect to '/login'
    end
  end


  get '/lipsticks/new' do
    if logged_in?
      erb :'lipsticks/new'
    else
      redirect '/login'
    end
  end


  post '/lipsticks' do
    if logged_in?
      if params[:color_scheme_main] == ""
        redirect '/lipsticks/new'
    else
      @lipstick = Lipstick.create(
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
      @lipstick.user_id = current_user.id
      @lipstick.save
        redirect "/lipsticks/#{@lipstick.id}"
      end
    else
      redirect '/login'
    end
  end


  get '/lipsticks/:id' do
    if logged_in?
      @lipstick = Lipstick.find_by_id(params[:id])
        erb :'lipsticks/show_lipstick'
    else
        redirect '/login'
      end
  end



  get '/lipstciks/:id/edit' do
    if logged_in?
       @lipstick = Lipstick.find_by_id(params[:id])
    if @lipstick && @lipstick.user == current_user
        erb :'lipstciks/edit_lipstick'
    else
        redirect '/lipstciks'
        end
    else
        redirect '/login'
      end
    end

  patch '/lipsticks/:id' do
    if logged_in?
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
    else
          redirect '/login'
        end
    end
    
    delete '/lipsticks/:id/delete' do
      if logged_in?
        @lipstick = Lipstick.find_by_id(params[:id])
      if @lipstick && @lipstick.user == current_user
        @lipstick.delete
      end

        redirect '/lipsticks'
      else
        redirect '/login'
      end
    end
end