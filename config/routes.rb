Rails.application.routes.draw do
  root "tops#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new, :edit, :update]
  resource :profile, only: [:new, :create, :show, :edit, :update]
  get 'profile/existence', to: "profiles#existence"
  resources :password_resets, only: [:create, :edit, :update, :new]

  resources :competitions do
    resource :competition_record, only: [:destroy]
    scope module: 'record' do
      # 各ステップのルーティング
      resource :weigh_in, only: [:new, :create, :edit, :update]
      resource :squat, only: [:new, :create, :edit, :update]
      resource :bench_presse, only: [:new, :create, :edit, :update]
      resource :deadlift, only: [:new, :create, :edit, :update]
      resource :comment, only: [:new, :create, :edit, :update]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"

  get 'login', to: 'user_sessions#new', :as => :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', :as => :logout

  # LINE認証用
  get "oauth/callback", to: "oauths#callback"
  post "oauth/callback", to: "oauths#callback"
  get 'oauth/:provider', to: 'oauths#oauth', :as => :auth_at_provider
  # 利用規約とプライバシーポリシー
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  # Letter Opener Webのルーティング
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
