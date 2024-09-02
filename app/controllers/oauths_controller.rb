class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    login_at(params[:provider])
  end

  # rubocop:disable Metrics/MethodLength
  def callback
    provider = auth_params[:provider] # ストロングパラメータで受け取り
    if (@user = login_from(provider))
      redirect_to profile_existence_path, success: t('.success')
    else
      begin
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to profile_existence_path, success: t('.success')
      rescue # rubocop:disable Style/RescueStandardError
        redirect_to root_path, danger: t('.danger')
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
