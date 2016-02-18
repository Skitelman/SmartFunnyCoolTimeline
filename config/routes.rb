Rails.application.routes.draw do
  root 'timeline#index'

  post '/search', to: 'timeline#search', as: 'search'
end
