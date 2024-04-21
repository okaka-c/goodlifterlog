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
      redirect_to root_path
    else
	    # 登録が失敗したら再度新規登録画面へ
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(update_user_params)
      redirect_to profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, profile_attributes: [:gender, :birthday])
  end

  def update_user_params
    params.require(:user).permit(:name, profile_attributes: [:gender, :birthday, :id])
  end
end