class ProfilesController < ApplicationController
  def show
    @profile = current_user.profile
    @user = current_user
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

  def update_user_params
    params.require(:user).permit(:name, profile_attributes: [:gender, :birthday, :id])
  end
end
