Rails.application.routes.draw do

  get '/api/v1/trips', to: 'api/v1/trips#index'
  get '/api/v1/trips/:id', to: 'api/v1/trips#show'
  post '/api/v1/trips', to: 'api/v1/trips#create'
end
