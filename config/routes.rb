Rails.application.routes.draw do
  scope ":locale", locale: /en|vi/ do
    namespace :admins do
      resources :contacts, only: [:index, :show, :destroy]
      resources :newspapers, :products, :orders, :order_members, :users
      resources :categories do
        member do 
          get "pro_of_cate"
        end
      end
    end
    resources :carts
    resources :order_items
    resources :orders
    resources :order_members do 
      member do
        get 'update_coin_total'
      end
    end
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
    resources :searchs, only: [:new]
    resources :newspapers,only: [:index, :show]
    resources :categories, only: :show
    resources :admins, only: :index
    devise_for :users,skip: :omniauth_callbacks,path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'},:controllers => { :omniauth_callbacks => "callbacks"}
    resources :users, only: :show
  end
  mount Ckeditor::Engine => '/ckeditor'
  root 'products#index'

end
