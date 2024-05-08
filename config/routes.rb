Rails.application.routes.draw do
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  root "tops#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new, :edit, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :competitions do
    resource :competition_record, only: [:create, :new, :edit, :update, :destroy]
  end
  # Defines the root path route ("/")
  # root "articles#index"

  get 'login', to: 'user_sessions#new', :as => :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', :as => :logout
end
