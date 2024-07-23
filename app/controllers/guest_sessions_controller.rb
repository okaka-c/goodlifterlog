class GuestSessionsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :restrict_guest_user_actions

  def create
    guest_user = User.find_by(role: 'guest')
    auto_login(guest_user)
    redirect_to competitions_path, success: 'ゲストユーザーとしてログインしました'
  end
end
