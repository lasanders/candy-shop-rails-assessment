Rails.application.routes.draw do
  # resources :purchases
    
 root 'users#home'
    get '/users' => 'users#new'
 
    post '/users' => 'users#create'
   
   get '/signin', to: 'sessions#new', as: 'signin'
   post '/sessions', to: 'sessions#create'
#   devise_for :users, controllers: { omniauth_callbacks: 'auth/google_oauth2/callback' }
#   post 'auth/request', to:'authorization#get_authorization'
   get '/auth/google_oauth2', to: 'sessions#create'
   post '/auth/google_oauth2', to: 'sessions#create'
   get '/signout', to: 'sessions#destroy'
   delete '/signout', to: 'sessions#destroy'
   get '/delete', to: 'candies#destroy'
   delete '/delete', to: 'candies#destroy'
   # get '/rides', to: 'rides#new'
  post '/purchases', to: 'purchases#create'
 
   resources :users
  resources :candies
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
