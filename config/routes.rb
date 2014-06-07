Rails.application.routes.draw do
  coord_regex = /(\-)?\d+(\.\d+)?/

  get 'cities/:lat/:lng', to: 'cities#show', lat: coord_regex, lng: coord_regex
  get 'cities', to: 'cities#show'
  get '/:lat/:lng', to: 'cities#index', as: :city, lat: coord_regex, lng: coord_regex

  root to: 'cities#index'

  # Last route is a city search
end
