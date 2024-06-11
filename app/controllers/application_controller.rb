class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_bottom_navi
  add_flash_types :success, :danger

  private

  def not_authenticated
    redirect_to login_path
  end

  def set_bottom_navi
	  @show_bottom_nav = true
  end
end
