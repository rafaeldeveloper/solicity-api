Rails.application.routes.draw do
   
  resources :requests
  resources :services
  resources :categories
   devise_for :users, controllers: {
  	sessions: 'users/sessions',
  	registrations: 'users/registrations'
  }

  devise_scope :user do
  	 get '/sync', to: 'users/sessions#sync'
  end	

  post '/register', to: 'messages#set_app_id'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
