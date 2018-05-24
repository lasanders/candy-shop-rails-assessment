Rails.application.routes.draw do
  # resources :purchases
   root 'users#home'
    

    get '/users' => 'users#new'
 
    post '/users' => 'users#create'
   
   get '/signin', to: 'sessions#new', as: 'signin'
   get '/auth/google_oauth2/callback' => 'sessions#other_create'
   post '/sessions', to: 'sessions#create'
   post '/auth/google_oauth2/callback' => 'sessions#other_create'
    get '/users/:id/candies' => 'users#candies', as: 'user_candies'
    post '/users/:id/candies' => 'users#candies'
    #   get '/users/:user_id/purchases/new' => 'purchases#new', as: 'user_new_purchase'
    #  post '/users/:user_id/purchases/create' => 'purchases#create'
     # get '/users/:user_id/purchases/:id' => 'purchases#show', as: 'user_purchase'
     # post '/users/:user_id/purchases/:id' => 'purchases#show'

   get '/signout', to: 'sessions#destroy'
   delete '/signout', to: 'sessions#destroy'
   get '/signout', to: 'sessions#other_destroy'
    delete '/signout', to: 'sessions#other_destroy'
   get '/delete', to: 'candies#destroy'
   post '/delete', to: 'candies#destroy'
  post '/purchases', to: 'purchases#create'
  
   resources :users do
       resources :purchases, only: [:show, :new]
        
     end
    
  
    resources :users
      resources :candies
    resources :purchases
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

