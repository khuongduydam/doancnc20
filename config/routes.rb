Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'products#index'
  namespace :admins do
    resources :newspapers, :products, :users, :categories
  end
  resources :admins,:newspapers,:categories,only: [:index, :show]
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'},
             :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users, only: :show
  end
  #resources :admins, only: :index
  resources :categories, only: [:index, :show]
  #########jane
  resources :orders do
    collection do 
      get "ordertemplate"
    end
  end
  resources :products, only: [:index, :show] do
    resources :comments, module: :products 
  end
 ## resources :users, only: :show
  resources :comments, except: [:index, :new]
  resources :wishlists, only: [:index, :create, :destroy]
  resources :shoppingguides do
    collection do 
      get "shoppingguide"     
    end
  end
  resources :contacts do
    collection do 
      get "contacts"      
    end
  end

end
