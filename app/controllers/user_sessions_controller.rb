class UserSessionsController < ApplicationController
  # ログアウトのみ
  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('.success')
  end
end
