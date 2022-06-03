Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/api/v1/users/:user_id/items", to: "items#index"

  get "/api/v1/users/:user_id/items/:item_id", to: "items#show"



  get '/api/v1/users/:user_id/trips', to: 'api/v1/trips#index'
  get '/api/v1/trips/:id', to: 'api/v1/trips#show'
  post '/api/v1/users/:user_id/trips', to: 'api/v1/trips#create'


end
