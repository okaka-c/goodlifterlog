class ProfilesController < ApplicationController
    def show
        @profile = current_user.profile
        @user = current_user
    end
end
