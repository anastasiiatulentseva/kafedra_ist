class StaticPagesController < ApplicationController

  before_action :get_user

  def home
  end

  def contacts
  end

  private

  def get_user
    @user = current_user
  end

end
