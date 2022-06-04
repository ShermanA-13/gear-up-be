Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/api/v1/users', to: 'api/v1/users#index'
  get '/api/v1/users/:id', to: 'api/v1/users#show'
  post '/api/v1/users', to: 'api/v1/users#create'

  get "/api/v1/users/:user_id/items", to: "api/v1/items#index"
  get "/api/v1/users/:user_id/items/:item_id", to: "api/v1/items#show"
  post "/api/v1/users/:user_id/items", to: "api/v1/items#create"

  get '/api/v1/users/:user_id/trips', to: 'api/v1/trips#index'
  get '/api/v1/trips/:id', to: 'api/v1/trips#show'
  post '/api/v1/users/:user_id/trips', to: 'api/v1/trips#create'

  get '/api/v1/trips/:id/users', to: 'api/v1/trips/users#index'
end
