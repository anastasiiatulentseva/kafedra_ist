class Special::WorkbooksController < PrivateAreaController
  before_action :set_user

  def new
    @special_workbook = Workbook.new
    @special_subjects = Subject.special
  end

  def show
    @special_workbook = Workbook.find(params[:id])
  end

  def index
    @subjects = Subject.all
    @workbooks = Workbook.all
    subject_name = params[:subject]
    if subject_name
      pill_subject = Subject.find(params[:subject])
      @panel_workbooks = @workbooks.select { |w| w.subject_id == pill_subject.id }
      @panel_heading = pill_subject.name
    else
      @panel_workbooks = @workbooks.special
      @panel_heading = 'Special'
    end
  end

  def create
    @special_workbook = current_user.teacher_profile.workbooks.new(special_workbook_params)
    @special_subjects = Subject.special
    if @special_workbook.save
      flash[:success] = "Special workbook has been created"
      redirect_to special_workbook_path(@special_workbook)
    else
      render 'new'
    end
  end

  def edit
    @special_workbook = Workbook.find(params[:id])
    @special_subjects = Subject.special
  end

  def update
    @special_workbook = Workbook.find(params[:id])
    if @special_workbook.update_attributes(special_workbook_params)
      flash[:success] = "Special workbook has been updated"
      redirect_to special_workbook_path
    else
      render 'edit'
    end
  end

  def destroy
    @special_workbook = Workbook.find(params[:id]).destroy
    flash[:info] = "Special workbook deleted"
    redirect_to special_workbooks_path
  end

  private

  def special_workbook_params
    params.require(:workbook).permit(:name, :description, :subject_id, :attachment)
  end

  def set_user
    @user = current_user
  end
end
