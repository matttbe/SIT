SolidareItG6::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
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

  #group routing
  get '/group/:id' => 'group#show', :as => 'show_group' 

  #users routing
  get '/user/:user_id' => 'users#show', :as => "show_profile"  
  get '/following/services' => 'services#following_services', :as=>"following_services"

  #services routing
  get '/user/:user_id/services/' => 'users#my_services', :as =>"my_services"
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
    get "sign_in", :to => "devise/sessions#new", as:"sign_in"
    get "create_account", :to =>"devise/registrations#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
    #get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  #address routing
  resources :address
  get '/org_adresses/:org_id/new' => 'address#new', :as => "new_address_org"
  get '/org_adresses/:org_id/main' => 'address#main', :as =>"main_address_org"
  post '/org_adresses/:org_id/create'=> 'address#create', :as=>'create_address_org'
  get '/managed_adresses/:man_id/new' => 'address#new', :as => "new_address_man"
  get '/managed_adresses/:man_id/main' => 'address#main', :as =>"main_address_man"
  post '/managed_adresses/:man_id/create'=> 'address#create', :as=>'create_address_man'
  #post '/adresses' => 'adresses#create', :as=>"addresses_create_path"
  get '/adresses/:id/main' =>'address#main', :as=> "main_address"

  
  #follower routing
  get '/service/:id/follow' => 'services#follow', :as=>"follow"
  get '/service/:id/unfollow/:follower_id' => 'services#unfollow', :as=>"unfollow" 
  
  #notification routing
  get '/notifications' => 'notifications#show', :as => "show"


  #orga admin
  match 'organisation_manage/:id_orga/managed_users/:id_coworker/new'=> 'organisation_manage/managedusers#new', via: :get, :as=>'new_managed_user_for_coworker'

  #categories routing 
  get 'child_categories/:id' => 'application#get_child_categories'

  
end
