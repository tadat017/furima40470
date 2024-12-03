Rails.application.routes.draw do
  get 'items/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'items#index'
  resources :items do
  resources :orders, only: [:index, :new, :create]
  end
  resources :categories, only: [:show]
  # Defines the root path route ("/")
  # root "articles#index"
end
