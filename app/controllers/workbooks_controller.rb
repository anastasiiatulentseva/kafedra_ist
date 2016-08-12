class WorkbooksController < PrivateAreaController
  load_and_authorize_resource
  before_action :set_user

  def show
    @workbook = Workbook.find(params[:id])
  end

  def index
    @subjects = Subject.all

    if current_user.teacher?
      @subjects = @user.subjects
      subject_name = params[:subject]
      if subject_name
        @pill_subject = Subject.find(params[:subject])
        @workbooks = @user.workbooks.where(subject_id: @pill_subject.id)
        @panel_heading = @pill_subject.name
      else
        @pill_subject = @user.subjects
        @workbooks = @user.workbooks
        @panel_heading = 'All'
      end
    else
      @workbooks = Workbook.all
    end
  end

  def new
    @workbook = Workbook.new
  end

  def create
    @workbook = current_user.workbooks.new(workbook_params)
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
