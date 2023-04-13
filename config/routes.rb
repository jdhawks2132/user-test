Rails.application.routes.draw do
  namespace :external_users do
    resources :sessions, only: [:create, :destroy]
  end

  resources :primary_users, only: %i[index create]
  resources :delegate_users, only: [:create]
  post 'primary_users/upload', to: 'primary_users#upload'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
