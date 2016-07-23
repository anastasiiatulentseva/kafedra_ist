class StaticPagesController < ApplicationController

  def home
    @user = current_user
  end

  def contacts
    @user = current_user
  end

end
