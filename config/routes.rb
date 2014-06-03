Rails.application.routes.draw do
  get 'cities/:city', to: 'cities#show'
  get 'cities', to: 'cities#show'

  root to: 'cities#index'

  # Last route is a city search
  get '/:city', to: 'cities#index'
end
