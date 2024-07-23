class UserSessionsController < ApplicationController
  skip_before_action :restrict_guest_user_actions

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('.success')
  end
end
