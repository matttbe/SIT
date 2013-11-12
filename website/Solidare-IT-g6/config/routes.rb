SolidareItG6::Application.routes.draw do
  
  # devise_for :admin_users, ActiveAdmin::Devise.config ## => we took info from Devise
  ActiveAdmin.routes(self)
  devise_for :users
  #ActiveAdmin.routes(self)
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'index#home'

  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "create_account", :to =>"devise/registrations#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
    #get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
end
