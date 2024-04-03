class UsersController < ApplicationController
  def new
    @user = User.new
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

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end