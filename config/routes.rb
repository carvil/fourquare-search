FoursquareSearch::Application.routes.draw do

  resources :users, only: [] do
    resources :favourites, only: [:index]
  end

  # Callback URL from Foursquare
  match 'auth/:provider/callback', to: 'sessions#create'

  # Failure URL
  match 'auth/failure', to: redirect('/')

  # Destroy the session on sign out
  match 'signout', to: 'sessions#destroy', as: 'signout'

  # Allow post to search venues
  post 'search', to: 'venues#search', as: 'search'

  # Favourite a venue
  post 'favourite', to: 'venues#favourite', as: 'favourite'

  root :to => 'venues#index'
end
