class TopsController < ApplicationController
  skip_before_action :require_login
  def index
    @users = User.all
  end
end
