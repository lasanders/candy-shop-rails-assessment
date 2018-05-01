Rails.application.routes.draw do
  # resources :purchases
    
 root 'users#home'
    get '/users' => 'users#new'
 
    post '/users' => 'users#create'
   
   get '/sessions/new', to: 'sessions#new', as: 'signin'
   post '/sessions', to: 'sessions#create'
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
