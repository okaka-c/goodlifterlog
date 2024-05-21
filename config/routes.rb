Rails.application.routes.draw do
  namespace :record do
    get 'comments/new'
    get 'comments/create'
    get 'deadlifts/new'
    get 'deadlifts/create'
    get 'bench_presses/new'
    get 'bench_presses/create'
    get 'squats/new'
    get 'squats/create'
  end
  root "tops#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new, :edit, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :password_resets, only: [:create, :edit, :update, :new]
  resources :competitions do
    resource :competition_record, only: [:create, :new, :edit, :update, :destroy]
  end
  # Defines the root path route ("/")
  # root "articles#index"

  get 'login', to: 'user_sessions#new', :as => :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', :as => :logout

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
