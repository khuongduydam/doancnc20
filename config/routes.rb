Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'}
  # mount Ckeditor::Engine => '/ckeditor'
  root 'homes#index'
  namespace :admins do
    resources :informations, :products, :users, :categories
  end
  resources :users, only: :show
  resources :admins, only: :index
  resources :informations,:categories,:products, only: [:index, :show]
end
