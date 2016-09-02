class StaticPagesController < ApplicationController

  before_action :set_user

  def home
    @feedback_message = ::FormObjects::UserFeedback.new
  end

  def contacts
  end

  private

  def set_user
    @user = current_user
  end

end
