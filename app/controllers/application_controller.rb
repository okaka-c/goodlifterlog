class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_header_navi
  before_action :set_bottom_navi
  add_flash_types :success, :danger, :warning
  before_action :restrict_guest_user_actions

  private

  def restrict_guest_user_actions
    return unless current_user&.guest? && action_name.in?(%w[new create edit update destroy])

    redirect_to competitions_path, danger: 'ゲストユーザーは新規登録・編集・削除機能を実行できません。'
  end

  def not_authenticated
    redirect_to root_path, warning: 'ログインしてください'
  end

  def set_bottom_navi
    @show_bottom_nav = true
  end

  def hide_bottom_navi
    @show_bottom_nav = false
  end

  def set_header_navi
    @show_header_nav = true
  end

  def hide_header_navi
    @show_header_nav = false
  end
end
