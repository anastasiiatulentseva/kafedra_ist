class UsersController < PrivateAreaController

  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
  end

  def index
    user_scope = params[:type]
    user_role = params[:role]

    if user_role
      @users = User.registered.with_role(user_role.to_sym).order(:name).paginate(page: params[:page])
    else
      if user_scope
        @users = with_user_scope(user_scope).order(:confirmed_at).paginate(page: params[:page])
      else
        @users = User.registered.order(confirmed_at: :desc).paginate(page: params[:page])
      end
    end
  end

  def set_subjects
    @user = User.find(params[:id])
    @specialties = Specialty.all
    @subjects = Subject.where(user_id: (nil || @user.id))

    if request.post? # TODO: break up into two actions
      @user.subjects.update_all(user_id: nil)
      Subject.where(id: params[:subjects]).update_all(user_id: @user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.js
      else
        format.js {render :js => "alert('Cannot update user');"}
      end
    end
  end

  def ban
    @user = User.find(params[:id])
    @user.banned_at = Time.now
    respond_to do |format|
      if @user.save
        format.js
      else
        format.js {render :js => "alert('Cannot ban user');"}
      end
    end
  end

  def unban
    @user = User.find(params[:id])
    @user.banned_at = nil
    respond_to do |format|
      if @user.save
        format.js
      else
        format.js {render :js => "alert('Cannot unban user');"}
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

  def with_user_scope(scope)
    case scope
    when 'without_role'
      User.without_role
    when 'banned'
      User.banned
    else
      fail "Unknown scope"
    end
  end

  def user_params
    params.require(:user).permit(:banned_at, :roles => [] )
  end

end
