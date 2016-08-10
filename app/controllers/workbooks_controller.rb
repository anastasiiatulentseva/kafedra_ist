class WorkbooksController < PrivateAreaController
  load_and_authorize_resource

  def show
    @workbook = Workbook.find(params[:id])
  end

  def index
    @user = current_user
    @subjects = Subject.all
    if current_user.teacher?
      @workbooks = @user.workbooks
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
end
