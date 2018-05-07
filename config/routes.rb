Rails.application.routes.draw do
  # resources :purchases
    
 root 'users#home'
    get '/users' => 'users#new'
 
    post '/users' => 'users#create'
   
   get '/signin', to: 'sessions#new', as: 'signin'
   get '/oauth2callback' => 'sessions#other_create'
   post '/sessions', to: 'sessions#create'
   post '/oauth2callback' => 'sessions#other_create'
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
