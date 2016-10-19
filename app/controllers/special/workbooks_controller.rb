class Special::WorkbooksController < PrivateAreaController
  load_and_authorize_resource
  before_action :set_user

  def show
    @special_workbook = Workbook.find(params[:id])
  end

  def index
    if @user.student?
      @subjects = Subject.for_student(@user.student_profile).special
      @workbooks = Workbook.with_subject_ids(@subjects.map(&:id))
    else
      @subjects = Subject.all
      @workbooks = Workbook.all
    end

    subject_name = params[:subject]
    if subject_name
      pill_subject = Subject.find(params[:subject])
      @panel_workbooks = @workbooks.select { |w| w.subject_id == pill_subject.id }
      @panel_heading = pill_subject.name

    else
      @panel_workbooks = @workbooks.special
      @panel_heading = t('special')
    end

    @workbook_counts = @workbooks.group_by(&:subject_id).each_with_object(Hash.new(0)) do |(subj_id, workbooks), memo|
      memo[subj_id] = workbooks.length
    end
  end

  def new
    @special_workbook = Workbook.new
    @special_subjects = Subject.special
  end

  def create
    @special_workbook = current_user.teacher_profile.workbooks.new(workbook_params)
    @special_subjects = Subject.special
    if @special_workbook.save
      flash[:success] =  t('workbook_created')
      redirect_to special_workbook_path(@special_workbook)
    else
      render 'new'
    end
  end

  def edit
    @special_workbook = Workbook.find(params[:id])
    @special_subjects = Subject.special
    @special_workbook_name = @special_workbook.reload.name
  end

  def update
    @special_workbook = Workbook.find(params[:id])
    @special_subjects = Subject.special
    @special_workbook_name = @special_workbook.reload.name
    if @special_workbook.update_attributes(workbook_params)
      flash[:success] =  t('workbook_updated')
      redirect_to special_workbook_path
    else
      render 'edit'
    end
  end

  def destroy
    @special_workbook = Workbook.find(params[:id]).destroy
    flash[:info] =  t('workbook_deleted')
    redirect_to special_workbooks_path
  end

  private

  def workbook_params
    params.require(:workbook).permit(:name, :description, :subject_id, :attachment)
  end

  def set_user
    @user = current_user
  end
end
