SolidareItG6::Application.routes.draw do

  resources :group do
	resources :group_posts do
	  resources :group_post_comments	
	end
  end
  
  resources :organisations

  resources :services
  
  resources :notifications

  resources :group_user_relation

  # devise_for :admin_users, ActiveAdmin::Devise.config ## => we took info from Devise
  ActiveAdmin.routes(self)
  devise_for :users
  #ActiveAdmin.routes(self)

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'index#home'

  #services routing
  get '/user/services' => 'services#my_services', :as =>"my_services"
  get '/user/following_services' => 'services#following_services', :as=>"following_services"
  get '/services/:id/accept' => 'services#accept_service', :as =>"accept_service"
  get '/users_managed/:serv_id/services/new' =>'services#new', :as =>"new_service_managed"
  get '/users_managed/:serv_id/managed_services/' => 'services#my_services', :as =>"managed_users_services"

  #search routing
  get '/search/(:page)' => 'search#match', :as=>"match"
  post '/search' => 'search#match'

  #transaction routing
  get '/transaction/:id' => 'services#new_transaction', :as=>"add_transaction"
  post '/transaction/:id' => 'services#create_transaction', :as=>"create_transaction"
  
  #organisation routing
  get '/manage_organisations' => 'organisations#manage', :as=>"manage_organisation"
  get '/join_organisations' => 'organisations#join_organisation', :as=>"join_organisation"
  get '/join_organisations/:id' => 'organisations#join_action', :as=>"join_action"
  get '/organisation_manage/:id/coworkers/' =>'organisation_manage/coworkers#index_organisation', :as=>'manage_coworkers'
  get '/mainmenu_organisations/:id' =>'organisations#show_main_panel', :as=>'mainmenu_organisations'
  get '/choose_organisations' =>'organisations#choose', :as=>'organisation_choose'
  
  #managed user routing
  get '/create_managed_user/:org_id' =>'organisations#new_managed', :as=>'new_managed'
  post '/create_managed_user_filled' =>'organisations#create_managed', :as=>'new_managed_created'
  get '/manage_user/:id' =>'organisation#manage', :as=>'manage'
  
  

  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "create_account", :to =>"devise/registrations#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
    #get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  #address routing
  resources :address

  #post '/adresses' => 'adresses#create', :as=>"addresses_create_path"
  get '/adresses/:id/main' =>'address#main', :as=> "main_address"

  
  #follower routing
  get '/service/:id/follow' => 'services#follow', :as=>"follow"
  get '/service/:id/unfollow/:follower_id' => 'services#unfollow', :as=>"unfollow" 
  
  #notification routing
  get '/notifications' => 'notifications#show', :as => "show"
  
end
