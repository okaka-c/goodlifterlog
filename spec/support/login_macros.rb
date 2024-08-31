# frozen_string_literal: true

module LoginMacros
  def login(user)
    setup_oauth_stubs(user)
    visit root_path
    click_on 'LINEログイン'
  end

  private

  def setup_oauth_stubs(user)
    # OauthsControllerのoauthアクションをスタブしてLINEプラットフォームへの認証処理をスキップ
    allow_any_instance_of(OauthsController).to receive(:oauth) do |object|
      object.redirect_to(object.url_for(controller: 'oauths', action: 'callback', provider: 'line'))
    end

    # OauthsControllerのcallbackアクション内をスタブしてLINEプラットフォームへの認証処理をスキップ
    allow_any_instance_of(OauthsController).to receive(:callback) do |object|
      object.auto_login(user)
      object.redirect_to(object.url_for(controller: 'profiles', action: 'existence'), success: 'LINEログインしました')
    end
  end
end
