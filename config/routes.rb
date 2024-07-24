Rails.application.routes.draw do
  get 'items/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'items#index'
  resources :items, only: [:new, :create]
  resources :orders, only:[:create]
  # Defines the root path route ("/")
  # root "articles#index"
end
