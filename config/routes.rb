Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index show]
      resources :primary_users, only: %i[index create]
      resources :delegate_users, only: %i[index create]
      post 'primary_users/upload', to: 'primary_users#upload'
    end
  end
  namespace :external_users do
    resources :sessions, only: %i[create destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
