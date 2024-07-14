Rails.application.routes.draw do
  root "tops#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :profile, only: [:new, :create, :show, :edit, :update]
  get 'profile/existence', to: "profiles#existence"
  resources :password_resets, only: [:create, :edit, :update, :new]
  resources :charts, only: [:index]
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

  # ログアウト
  delete 'logout', to: 'user_sessions#destroy', :as => :logout

  # LINE認証用
  get "oauth/callback", to: "oauths#callback"
  post "oauth/callback", to: "oauths#callback"
  get 'oauth/:provider', to: 'oauths#oauth', :as => :auth_at_provider
  # LINE messaging APIのHTTP POSTリクエスト受信用
  post "/callback", to: "line_bot#callback"
  # 利用規約とプライバシーポリシー
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  # Letter Opener Webのルーティング
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
