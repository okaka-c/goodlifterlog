class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def terms; end

  def privacy_policy; end
end
