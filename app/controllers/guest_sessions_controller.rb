class GuestSessionsController < ApplicationController
  skip_before_action :require_login
  def create
    guest_user = User.find_by(role: 'guest')
    auto_login(guest_user)
    redirect_to competitions_path, notice: 'ゲストユーザーとしてログインしました'
  end
end
