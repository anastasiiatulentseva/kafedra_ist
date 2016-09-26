class TeachersSchedulesController < PrivateAreaController

  def show
    @teachers_schedule = TeachersSchedule.find(params[:id])
    @days = ['Monday', 'Tuesday', 'Wednsday', 'Thursday', 'Friday']
  end

  def new
    @teachers_schedule = TeachersSchedule.new
    @teachers = User.with_role(:teacher).order(:name)
    @days = ['Monday', 'Tuesday', 'Wednsday', 'Thursday', 'Friday']
  end

  def create
    @teachers_schedule = TeachersSchedule.new(week: params[:week], schedule: params[:schedule])
    if @teachers_schedule.save
      redirect_to teachers_schedule_path(@teachers_schedule)
      flash[:success] = "Teachers schedule has been created"
    else
      render 'new'
    end
  end

end

