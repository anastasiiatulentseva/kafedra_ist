class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
  end

  def index
    user_scope = params[:role]
    user_type = params[:type]

    if user_type
      @users = User.registered.with_role(user_type.to_sym).order(:name).paginate(page: params[:page])
    else
      if user_scope
        @users = User.registered.without_role.order(:confirmed_at).paginate(page: params[:page])
      else
        @users = User.registered.order(confirmed_at: :desc).paginate(page: params[:page])
      end
    end
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

  def destroy
    @user = User.find(params[:id]).destroy
    respond_to do |format|
      format.js  { render :layout => false }
    end
  end

  private

  def user_params
    params.require(:user).permit(:roles => [])
  end

end
