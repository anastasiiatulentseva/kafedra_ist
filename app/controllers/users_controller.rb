class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = current_user
  end

  def index
    @users = User.registered
  end

  def update

    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.js
      else
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:roles => [])
  end

end
