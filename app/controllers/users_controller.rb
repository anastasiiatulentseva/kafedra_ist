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
        @users = with_user_scope(user_scope).order(confirmed_at: :desc).paginate(page: params[:page])
      else
        @users = User.registered.order(confirmed_at: :desc).paginate(page: params[:page])
      end
    end
  end

  def choose_subjects
    @user = User.find(params[:id])
    @subjects = Subject.for_teacher_or_unassigned(@user.teacher_profile)
    @grouped_subjects = @subjects.group_by{|s| s.specialty.name }
  end

  def save_subjects
    @user = User.find(params[:id])
    @subjects = Subject.for_teacher_or_unassigned(@user.teacher_profile)
    @grouped_subjects = @subjects.group_by{|s| s.specialty.name }
    @user.teacher_profile.subjects.update_all(teacher_profile_id: nil)
    Subject.where(id: params[:subjects]).update_all(teacher_profile_id: @user.teacher_profile.id)
    redirect_to choose_subjects_user_path
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if user_params[:roles].include?('teacher') && !@user.teacher_profile
        @user.create_teacher_profile
      end
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
      User.registered.without_role
    when 'banned'
      User.registered.banned
    else
      fail "Unknown scope"
    end
  end

  def user_params
    params.require(:user).permit(:banned_at, :roles => [] )
  end

end
