Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'geo_secrets#index'
  resources :geo_secrets do
    collection do
      get 'get_secrets'
      get 'get_nearest_secret'
    end
  end
end
