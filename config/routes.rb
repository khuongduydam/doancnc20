Rails.application.routes.draw do
  resources :carts
  resources :order_items
  resources :orders
  resources :order_members do 
    member do
      get 'update_coin_total'
    end
  end
  
  mount Ckeditor::Engine => '/ckeditor'
  root 'products#index'
  namespace :admins do
    resources :contacts, only: [:index, :show, :destroy]
    resources :newspapers, :products, :users, :orders, :order_members
    resources :categories do
      member do 
        get "pro_of_cate"
      end
    end
  end
  resources :admins,:newspapers,only: [:index, :show]
  resources :categories, only: :show
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'},
             :controllers => { :omniauth_callbacks => "callbacks"}
  resources :users, only: :show
  #########jane
  resources :products, only: [:index, :show] do
    resources :comments, module: :products 
    collection do
      get "search_filter"
      get "all_pro"
    end
  end
  resources :comments, except: [:index, :new]
  resources :wishlists, only: [:index, :create, :destroy]
  resources :shoppingguides, only: :index 
  resources :contacts, only: [:new, :create]
end
