Rails.application.routes.draw do
  root "tops#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new]
  resources :competitions do
    resources :competition_records
  end
  # Defines the root path route ("/")
  # root "articles#index"

  get 'login', to: 'user_sessions#new', :as => :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', :as => :logout
end
