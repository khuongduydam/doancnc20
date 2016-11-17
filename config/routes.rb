Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'}
  root 'homes#index'
  namespace :admins do
    resources :news, :products, :users
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :admins, only: :index
end
