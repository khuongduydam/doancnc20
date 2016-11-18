Rails.application.routes.draw do
  get 'products/index' => 'products#index'

  root 'homepages#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
