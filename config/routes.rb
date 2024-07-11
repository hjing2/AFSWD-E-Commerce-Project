Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'categories/products'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root to: 'home#index'
  resources :products, only: [:index, :show]

  resources :categories, only: [:index, :show] do
    member do
      get 'products', to: 'categories#show'
    end
  end

  get 'home/search', to: 'home#search', as: 'search_home'
  get 'products/index'
  get 'products/show'
  get 'categories/index'
  get 'categories/show'
  get 'categories/products'
  get 'home/index'
  get 'contact', to: 'contact#show', as: 'contact'
  get 'about', to: 'about#show', as: 'about'



  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
