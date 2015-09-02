Rails.application.routes.draw do
   namespace :api do
   	  '''Session'''
      post "/signup" => "sessions#sign_up"
      post "/login" => "sessions#login"
      post "/logout" => "sessions#logout"
      post "/facebook_auth" => "sessions#facebook_authentication"
      get "/current_user" => "sessions#get_current_user"

      '''Causes '''
      post "/create_cause" => "causes#create"
      get "/causes/all"  => "causes#index"
      get "/causes/:id" => "causes#get"
      post "causes/:id/join" => "causes#join"

      '''Users '''
      get "/current_user/causes" => "causes#get_user_causes"
      post "/current_user/causes/leave" => "users#leave_current_cause"

   end
end
