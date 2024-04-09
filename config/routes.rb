Rails.application.routes.draw do
  namespace :api do
    resources :features, only: [:index] do
      resources :comments, only: [:index,:create]
    end
  end
end