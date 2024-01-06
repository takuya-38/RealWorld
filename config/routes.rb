Rails.application.routes.draw do
  namespace :api do
    resources :users
    post "/users/login", to: 'sessions#create'
  end
end
