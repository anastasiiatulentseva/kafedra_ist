class TeachersSchedulesController < PrivateAreaController

  def show
    @schedule = TeachersSchedule.find(params[:id])
  end

  def new
    @schedule = TeachersSchedule.new
    @teachers = User.with_role(:teacher)
    @days = ['Monday', 'Tuesday', 'Wednsday', 'Thursday', 'Friday']
  end

  def create
    @schedule = TeachersSchedule.new
    if @schedule.save
      redirect_to teachers_schedule_path(@schedule)
      flash[:success] = "Teachers schedule has been created"
    else
      render 'new'
    end
  end

  private

  # def teacher_schedule_params
  #   params.require(:teachers_schedule).permit(:date, :json => [] )
  # end
end

