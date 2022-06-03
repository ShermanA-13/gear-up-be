Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/v1/users', to: 'users#index'
  get '/api/v1/users/:id', to: 'users#show'
  post '/api/v1/users', to: 'users#create'
end
