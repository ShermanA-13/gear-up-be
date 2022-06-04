Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # Users Endpoints
  get "/api/v1/users", to: "api/v1/users#index"
  get "/api/v1/users/:id", to: "api/v1/users#show"
  post "/api/v1/users", to: "api/v1/users#create"

  # Items Endpoints
  get "/api/v1/users/:user_id/items", to: "api/v1/items#index"
  get "/api/v1/users/:user_id/items/:item_id", to: "api/v1/items#show"
  post "/api/v1/users/:user_id/items", to: "api/v1/items#create"
  patch "/api/v1/users/:user_id/items/:item_id", to: "api/v1/items#update"
  delete "/api/v1/users/:user_id/items/:item_id", to: "api/v1/items#destroy"

  # Trips Endpoints
  get "/api/v1/users/:user_id/trips", to: "api/v1/trips#index"
  get "/api/v1/trips/:id", to: "api/v1/trips#show"
  post "/api/v1/users/:user_id/trips", to: "api/v1/trips#create"

  # Trip Users Endpoints
  get '/api/v1/trips/:id/users', to: 'api/v1/trips/users#index'
  post '/api/v1/trips/:id/users', to: 'api/v1/trips/users#create'

  # Trip Items Endpoints
  get "/api/v1/trips/:trip_id/items", to: "api/v1/trip_items#index"
  post "/api/v1/trips/:trip_id/items", to: "api/v1/trip_items#create"
  delete "/api/v1/trips/:trip_id/items/:trip_item_id", to: "api/v1/trip_items#destroy"
end
