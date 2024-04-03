class TopsController < ApplicationController
  def index
    @users = User.all
  end
end
