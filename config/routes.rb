Rails.application.routes.draw do
  # Google Anonymous Sessions
  # https://stackoverflow.com/questions/4361994/create-named-routes-for-omniauth-in-rails-3
  get 'auth/:provider/callback', to: 'anonymous_sessions#create', as: :oauth_callback
  # get 'auth/:provider', as: :oauth
  get 'auth/failure', to: redirect('/')
  resources :anonymous_sessions, only: [:create]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # https://github.com/plataformatec/devise/wiki/How-To:-Change-Default-Sign_up---Registration-Path-with-Custom-Path
  devise_for :users, :controllers => {:registrations => "users/registrations"}


  # https://stackoverflow.com/questions/14416234/devise-redirect-automatically-from-root-url-if-signed-in
  authenticated :user do
    get 'site/show', to: 'site#show', as: 'show'
    # get 'categories/:id', to: 'categories#show', as: 'categories'
    post 'site/search'
    get 'site/main'
    root to: "site#main"
  end
  get 'site/home'
  get 'site/main', redirect: 'site/home'
  get 'userinfo/profile', to: 'userinfo#profile', as: 'profile'
  get 'userinfo/postuser.:user_id', to: 'userinfo#postuser', as: 'postuser'
  get 'userinfo/edit_profile', to: 'userinfo#edit_profile', as: 'edit_profile'
  patch 'userinfo/update_profile/:user_id', to: 'userinfo#update_profile', as: 'update_profile'
  root to: 'site#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ----------------  RESTful STYLE ROUTING  -----------

  resources :items do
    resources :comments, only: [:create, :update, :destroy]
    resources :bid_infos, only: [:create, :update, :destroy]
    resources :reports, only: [:create]
    put "like", to: "items#like"
    put "unlike", to: "items#unlike"
  end

  # For best-in-place https://stackoverflow.com/questions/23814255/nomethoderror-for-best-in-place-gem
  # Also for other js actions
  resources :comments, only: [:update, :destroy]
  resources :reports, only: [:destroy]
  resources :bid_infos, only: [:update, :destroy] # will created via nested actions

  # https://stackoverflow.com/questions/5246767/sti-one-controller
  resources :bid_items, :controller => :items, :type => "BidItem" do
    resources :comments, only: [:create, :update, :destroy]
    resources :bid_infos, only: [:create, :update, :destroy]
    resources :reports, only: [:create]
    put "like", to: "items#like"
    put "unlike", to: "items#unlike"
  end
  #
  resources :non_bid_items, :controller => :items, :type => "NonBidItem" do
    resources :comments, only: [:create, :update, :destroy]
    # resources :images
    resources :bid_infos, only: [:create, :update, :destroy]
    resources :reports, only: [:create]
    put "like", to: "items#like"
    put "unlike", to: "items#unlike"
  end

end
