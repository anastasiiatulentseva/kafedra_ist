class DashboardsController < PrivateAreaController

  def show
    authorize! :read, :dashboard

    @active_users_count = User.active.count
    @recent_users_count = User.recently_logged_in.count
    @teachers_count = User.with_role(:teacher).count
    @students_count = User.with_role(:student).count

    @articles_count = Article.count
    @workbooks_count = Workbook.count

    @specialties_count = Specialty.count
    @subjects_count = Subject.simple.count
  end
end
