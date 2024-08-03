Rails.application.routes.draw do
  get 'items/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #root to: 'items#index'
  root to: 'orders#index'
  resources :items do
  resources :orders, only:[:create,:index,:new]
  end
  resources :categories, only: [:show]
  # Defines the root path route ("/")
  # root "articles#index"
end
