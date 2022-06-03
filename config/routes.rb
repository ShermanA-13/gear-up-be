Rails.application.routes.draw do

  get '/api/v1/trips', to: 'api/v1/trips#index'
end
