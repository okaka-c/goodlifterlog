Rails.application.routes.draw do
  root "tops#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new]
  # Defines the root path route ("/")
  # root "articles#index"
end
