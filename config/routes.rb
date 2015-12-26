Rails.application.routes.draw do
   namespace :api do
      
   	'''Session'''
      post "/signup" => "sessions#sign_up"
      post "/login" => "sessions#login"
      post "/logout" => "sessions#logout"
      post "/facebook_auth" => "sessions#facebook_authentication"
      post "/create_cause" => "causes#create"
      get "/current_user" => "sessions#get_current_user"

      '''Causes '''
      get "/causes/all"  => "causes#index"
      get "/causes/:id" => "causes#get"
      post "/causes/categories" => "causes#get_causes_from_categories"
      post "causes/:id/join" => "causes#join"

      '''Users '''
      get "/current_user/causes" => "causes#get_user_causes"
      post "/current_user/causes/leave" => "users#leave_current_cause"
      post "/current_user/update/weekly_budget" => "users#update_weekly_budget"

      '''Contributions '''
      post "/contributions/add_card" => "contributions#add_card"
      post "/contributions/pay" => "contributions#pay"
      get "/current_user/contributions" => "contributions#get_user_contributions"
      get "/causes/:id/contributions" => "contributions#get_cause_contributions"

      '''Plaid '''
      post "/plaid/create" => "plaid_api#create_plaid_user"
      put "/plaid/update" => "plaid_api#retrieve_plaid_user"
      post "/plaid/answer" => "plaid_api#answer_security_question"
      put "/plaid/update/answer" => "plaid_api#retrieve_user_questions"
      get "/plaid/transactions" => "plaid_api#get_transactions"
      get "/plaid/banks" => "plaid_api#get_banks"


      '''Messages'''
      post "/message/create" => "messages#create"
      post "/message/get" => "messages#get"


      '''Conversations'''
      post "/conversation/create" => "conversations#create"
      post "/conversation/all" => "conversations#index"
      post "/conversation/all_cause" => "conversations#index_cause"
      post "/conversation/all_user" => "conversations#index_user"

      '''Blog Posts'''
      post "/blog_post/create" => "blog_posts#create"
      get "/blog_post/cause/:cause_id" => "blog_posts#index_cause"

      '''Blog Comments'''
      post "/blog_comment/create" => "blog_comments#create"
      get "/blog_comments/blog/:blog_post_id" => "blog_comments#get"

      '''Categories '''
      get "/categories"=>"categories#get_all_categories"
      post "/categories/choose" => "categories#choose_categories"

   end
   namespace :webapp do
      post "/create_organization" => "organization#sign_up"
      post "/login_organization" => "organization#login"
      put "/update_logo" => "organization#update_logo_url"
      post "/create_cause" => "causes#create"
      get "/causes/:id" => "causes#get"
   end
end
