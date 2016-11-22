Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path_names: {sign_in: 'login', sign_up: 'new', sign_out:'logout'}
  # mount Ckeditor::Engine => '/ckeditor'
  root 'products#index'
  namespace :admins do
    resources :newspapers, :products, :users, :categories
  end
# <<<<<<< HEAD
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :admins,:newspapers,:categories,only: [:index, :show]
  resources :products, only: [:index, :show] do
    collection do
      get 'new_products'
    end
  end
  resources :wishlists, only: [:index, :create, :destroy]
# =======
#   resources :admins, only: :index
#   #########jane
#   resources :products do
#     collection do 
#       get "traicaymienbac"
#       get "traicaymiennam"
#     end
#   end
#   resources :informations do
#     collection do 
#       get "information"
#       get "detail"     
#     end
#   end
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

# >>>>>>> 86b2e2420d51df9772aed5229d3a0e796ba3482e
end
