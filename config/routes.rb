Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :articles, only: %i[show create update destroy]
    post "/users/login", to: 'sessions#create'
  end
end
