Rails.application.routes.draw do
  root "tops#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new, :edit, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :password_resets, only: [:create, :edit, :update, :new]

  resources :competitions do
    resource :competition_record, only: [:destroy]
    scope module: 'record' do
      # 各ステップのルーティング
      resource :weigh_in, only: [:new, :create]
      resource :squat, only: [:new, :create]
      resource :bench_presse, only: [:new, :create]
      resource :deadlift, only: [:new, :create]
      resource :comment, only: [:new, :create]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"

  get 'login', to: 'user_sessions#new', :as => :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', :as => :logout

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
