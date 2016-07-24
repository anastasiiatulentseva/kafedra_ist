class StaticPagesController < ApplicationController

  before_action :set_user

  def home
  end

  def contacts
  end

  private

  def set_user
    @user = current_user
  end

end
