Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'}
  root 'products#index'
  namespace :admins do
    resources :newspapers, :products, :users, :categories
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :admins,:newspapers,:categories,only: [:index, :show]
  resources :products, only: [:index, :show] do
    collection do
      get 'new_products'
    end
  end
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
