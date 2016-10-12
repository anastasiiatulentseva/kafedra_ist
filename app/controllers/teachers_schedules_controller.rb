class TeachersSchedulesController < PrivateAreaController
  load_and_authorize_resource

  def show
    @teachers_schedule = TeachersSchedule.find(params[:id])
    @schedule = @teachers_schedule.schedule
    @date = @teachers_schedule.week.at_beginning_of_week
    @date_end = @teachers_schedule.week.at_end_of_week

    teacher_ids = @schedule.keys.uniq
    @teachers = teacher_ids.each_with_object({}) do |tid, memo|
      memo[tid] = User.find(tid)
    end
    @subject_ids = @schedule.values.each_with_object([]) do |days, acc|
      days.values.each do |lessons|
        lessons.each do |para, lesson|
          unless lesson["subject"].blank?
            acc << lesson["subject"]
          end
        end
      end
    end

    @subjects = @subject_ids.each_with_object({}) do |sid, memo|
      memo[sid] = Subject.find(sid)
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{t('activerecord.models.teachers_schedule')}_#{l @date, format: :simple_date}"
      end
    end

  end

  def new
    @teachers_schedule = TeachersSchedule.new
    @teachers = User.with_role(:teacher).order(:name)
  end

  def create
    @teachers_schedule = TeachersSchedule.new(week: params[:week], schedule: params[:schedule])
    if @teachers_schedule.save
      redirect_to teachers_schedule_path(@teachers_schedule)
      flash[:success] = t('schedule_created')
    else
      render 'new'
    end
  end

  def edit
    @teachers_schedule = TeachersSchedule.find(params[:id])
    @teachers = User.with_role(:teacher).order(:name)

  end

  def update
    @teachers_schedule = TeachersSchedule.find(params[:id])
    @teachers = User.with_role(:teacher).order(:name)
    if @teachers_schedule.update_attributes(week: params[:week], schedule: params[:schedule] )
      flash[:success] = t('schedule_updated')
      redirect_to teachers_schedule_path(@teachers_schedule)
    else
      flash[:danger] = "Something went wrong"
      render 'edit'
    end
  end

end

