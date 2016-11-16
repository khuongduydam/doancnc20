Rails.application.routes.draw do
  get 'products/index' => 'products#index'
  resources :products do
  	collection do 
  		get "traicaynhap"
  		get "traicaymienbac"
  		get "traicaymiennam"
  	end
  end
  resources :informations do
  	collection do 
  		get "information"  		
  	end
  end
  resources :contacts do
  	collection do 
  		get "contacts"  		
  	end
  end

 	root 'homepages#index'
 	get '/contact' => 'homepages#contact'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
