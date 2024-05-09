class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  # PWリセット申請ページを表示する
  def new; end

  # ユーザーがパスワードリセットフォームにメールアドレスを入力して送信したときに実行
  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path
  end

  # パスワード再設定フォーム。受信したメールのリンクから実行される
  # トークンでユーザーを検索し、有効期限もチェック
  # トークンが見つかり, 有効であればそのユーザーを返す
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
    # 認証されていないユーザーを拒否する root_pathに返す
  end

  #ユーザーがパスワードリセットフォームを送信したときに実行されます。
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
