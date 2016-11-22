Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'},
             :controllers => { :omniauth_callbacks => "callbacks" }
  # mount Ckeditor::Engine => '/ckeditor'
  root 'products#index'
  namespace :admins do
    resources :informations, :products, :users, :categories
  end
  resources :admins, only: :index
  resources :categories, only: [:index, :show]
  #########jane
  resources :products do
    collection do 
      get "traicaymienbac"
      get "traicaymiennam"
    end
    resources :comments, module: :products 
  end
  resources :users, only: :show
  resources :comments, except: [:index, :new]
  resources :informations, only: :information do
    collection do 
      get "information"
      get "detail"     
    end
  end
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
