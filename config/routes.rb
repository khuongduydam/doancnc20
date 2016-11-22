Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'}
  # mount Ckeditor::Engine => '/ckeditor'
  root 'products#index'
  namespace :admins do
    resources :informations, :products, :users, :categories
  end
  resources :users, only: :show do
    resources :comments
  end
  resources :admins, only: :index
  resources :categories, only: [:index, :show]
  resources :comments do
    resources :comments
  end
  #########jane
  resources :orders do
    collection do 
      get "ordertemplate"
    end
  end
  resources :products do
    collection do 
      get "traicaymienbac"
      get "traicaymiennam"
      get "detailproduct"
    end
  end
  resources :informations do
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
