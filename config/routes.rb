Rails.application.routes.draw do
  resources :orders
  resources :order_items
  resources :carts, except: :index
  get '/carts' => 'products#index'
  mount Ckeditor::Engine => '/ckeditor'
  root 'products#index'
  namespace :admins do
    resources :contacts, only: [:index, :show, :destroy]
    resources :newspapers, :products, :users, :orders
    resources :categories do
      member do 
        get "pro_of_cate"
      end
    end
  end
  resources :admins,:newspapers,only: [:index, :show]
  resources :categories, only: :show
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'},
             :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users, only: :show
  resources :categories, only: [:index, :show]
  #########jane
  resources :products, only: [:index, :show] do
    resources :comments, module: :products 
  end
  resources :comments, except: [:index, :new]
  resources :wishlists, only: [:index, :create, :destroy]
  resources :shoppingguides do
    collection do 
      get "shoppingguide"     
    end
  end
  resources :contacts
end
