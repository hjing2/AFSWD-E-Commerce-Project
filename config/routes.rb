Rails.application.routes.draw do
  get 'ai_bots/new'
  get 'ai_bots/create'


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

  resource :cart, only: [:show] do
    post 'add_product/:product_id', to: 'carts#add_product', as: 'add_product'
    delete 'remove_product/:product_id', to: 'carts#remove_product', as: 'remove_product'
  end
  resources :cart_items, only: [:create, :update, :destroy]

  resources :orders, only: [:new, :create, :show, :index] do
    collection do
      post 'confirm', to: 'orders#confirm', as: 'confirm_order'
    end
    member do
      get 'success', to: 'orders#success', as: 'success'
    end
  end

  resource :ai_bots, only: [:new, :create]

  get 'home/search', to: 'home#search', as: 'search_home'
  get 'products/index'
  get 'products/show'
  get 'categories/index'
  get 'categories/show'
  get 'categories/products'
  get 'home/index'
  get 'contact', to: 'contact#show', as: 'contact'
  get 'about', to: 'about#show', as: 'about'
  get 'order_success/:id', to: 'orders#success', as: 'order_success'
  get 'orders/new'
  get 'orders/create'
  get 'cart_items/create'
  get 'cart_items/update'
  get 'cart_items/destroy'
  get 'carts/show'
  get 'categories/index'
  get 'categories/show'
  get 'categories/products'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
