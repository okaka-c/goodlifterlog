class ProfilesController < ApplicationController
  skip_before_action :set_header_navi, only: %i[new]
  before_action :hide_header_navi, only: %i[create]
  skip_before_action :set_bottom_navi, only: %i[new edit]
  before_action :hide_bottom_navi, only: %i[create update]
  def existence
    if current_user.profile.present?
      # プロフィールが存在する場合,大会結果一覧へ
      redirect_to competitions_path
    else
      # プロフィール登録が未の場合,新規登録ページへ
      redirect_to new_profile_path
    end
  end

  def show
    @profile = current_user.profile
    @user = current_user
  end

  def new
    @profile = Profile.new
  end

  def edit
    @user = current_user
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user
    if @user.update(update_user_params)
      redirect_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:gender, :birthday)
  end

  def update_user_params
    params.require(:user).permit(:name, profile_attributes: %i[gender birthday id])
  end
end
