Rails.application.routes.draw do
  root 'tops#index'
  post 'guest_login', to: 'guest_sessions#create'
  resource :profile, only: %i[new create show edit update]
  get 'profile/existence', to: 'profiles#existence'
  resources :password_resets, only: %i[create edit update new]
  resources :charts, only: [:index]
  resources :competitions do
    resource :competition_record, only: [:destroy]
    scope module: 'record' do
      # 各ステップのルーティング
      resource :weigh_in, only: %i[new create edit update]
      resource :squat, only: %i[new create edit update]
      resource :bench_presse, only: %i[new create edit update]
      resource :deadlift, only: %i[new create edit update]
      resource :comment, only: %i[new create edit update]
    end
  end

  # ログアウト
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # LINE認証用
  get 'oauth/callback', to: 'oauths#callback'
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  # LINE messaging APIのHTTP POSTリクエスト受信用
  post '/callback', to: 'line_bot#callback'
  # 利用規約とプライバシーポリシー
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  # Letter Opener Webのルーティング
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
