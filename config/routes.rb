Rails.application.routes.draw do
  resources :cities, only: [:index]
  root to: 'cities#index'

  # Last route is a city search
  get '/:city', to: 'cities#index'
end
