class WorkbooksController < PrivateAreaController
  load_and_authorize_resource
  before_action :set_user

  def show
    @workbook = Workbook.find(params[:id])
  end

  def index
    if current_user.teacher?
      @subjects = @user.teacher_profile.subjects
      @workbooks = @user.teacher_profile.workbooks
    else
      @subjects = Subject.where(specialty_id: @user.student_profile.specialty_id, course_year: @user.student_profile.course_year)
      @workbooks = Workbook.with_subject_ids(@subjects.map(&:id))
    end

    subject_name = params[:subject]
    if subject_name
      pill_subject = Subject.find(params[:subject])
      @panel_workbooks = @workbooks.select { |w| w.subject_id == pill_subject.id }
      @panel_heading = pill_subject.name
    else
      @panel_workbooks = @workbooks
      @panel_heading = 'All'
    end
  end

  def new
    @workbook = Workbook.new
  end

  def create
    @workbook = current_user.teacher_profile.workbooks.new(workbook_params)
    if @workbook.save
      flash[:success] = "Workbook has been created"
      redirect_to workbook_path(@workbook.id)
    else
      render 'new'
    end
  end

  def edit
    @workbook = Workbook.find(params[:id])
  end

  def update
    @workbook = Workbook.find(params[:id])
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
