Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'}
  # mount Ckeditor::Engine => '/ckeditor'
  root 'homes#index'
  namespace :admins do
    resources :informations, :products, :users, :categories
  end
  resources :users, only: :show do
    resources :comments
  end
  resources :admins, only: :index
  resources :informations,:categories,:products, only: [:index, :show]
  resources :comments do
    resources :comments
  end
end
