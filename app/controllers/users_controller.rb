class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
    # 登録が完了したら仮のtopのindex.html.elbへリダイレクト
      redirect_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
    # 登録が失敗したら再度新規登録画面へ
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, profile_attributes: [:gender, :birthday])
  end

  
end