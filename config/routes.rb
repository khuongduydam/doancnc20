Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'}
  root 'homes#index'
  namespace :admin do
    resources :news, :products, :admins
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  get '/admin' => 'admin/admins#index'
end
