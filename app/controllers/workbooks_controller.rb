class WorkbooksController < PrivateAreaController
  load_and_authorize_resource
  before_action :set_user

  def show
    @workbook = Workbook.find(params[:id])
  end

  def index
    if @user.teacher?
      @subjects = @user.teacher_profile.subjects.simple
      @workbooks = @user.teacher_profile.workbooks.simple
    else
      @subjects = Subject.for_student(@user.student_profile).simple
      @workbooks = Workbook.with_subject_ids(@subjects.map(&:id))
    end

    subject_name = params[:subject]
    if subject_name
      pill_subject = Subject.find(params[:subject])
      @panel_workbooks = @workbooks.select { |w| w.subject_id == pill_subject.id }
      @panel_heading = pill_subject.name
      if pill_subject.teacher_profile
        @teacher = pill_subject.teacher_profile.user
      end
    else
      @panel_workbooks = @workbooks
      @panel_heading = 'All'
    end
    @workbook_counts = @workbooks.group_by(&:subject_id).each_with_object(Hash.new(0)) do |(subj_id, workbooks), memo|
      memo[subj_id] = workbooks.length
    end
  end

  def new
    @workbook = Workbook.new
    @subjects = current_user.teacher_profile.subjects.simple
  end

  def create
    @workbook = current_user.teacher_profile.workbooks.new(workbook_params)
    @subjects = current_user.teacher_profile.subjects.simple
    if @workbook.save
      flash[:success] = "Workbook has been created"
      redirect_to workbook_path(@workbook.id)
    else
      render 'new'
    end
  end

  def edit
    @workbook = Workbook.find(params[:id])
    @subjects = current_user.teacher_profile.subjects.simple
  end

  def update
    @workbook = Workbook.find(params[:id])
    @subjects = current_user.teacher_profile.subjects.simple
    if @workbook.update_attributes(workbook_params)
      flash[:success] = "Workbook has been updated"
      redirect_to workbook_path
    else
      render 'edit'
    end
  end

  def destroy
    @workbook = Workbook.find(params[:id]).destroy
    flash[:info] = "Workbook deleted"
    redirect_to workbooks_path
  end

  private

  def workbook_params
    params.require(:workbook).permit(:name, :description, :subject_id, :attachment)
  end

  def set_user
    @user = current_user
  end
end
