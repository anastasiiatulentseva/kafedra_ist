module QueryObjects
  class FindUsersForMailout

    attr_reader :params

    def initialize(params)
      @params = params
    end

    # @returns [Enumerable] collection of users to send mails to.
    def call
      if students?
        criteria = User.with_role(:student)

        criteria = students_by_specialties(criteria) if params[:form_objects_mass_mailout][:specialty_ids].present?
        criteria = students_by_course_year(criteria) if params[:form_objects_mass_mailout][:course_years].present?
        criteria = students_by_group(criteria) if params[:form_objects_mass_mailout][:groups].present?

        criteria
      elsif teachers?
        User.with_role(:teacher)
      else
        User.active
      end
    end

    private

    def role
      params[:form_objects_mass_mailout][:role]
    end

    def teachers?
      role.include?('teachers')
    end

    def students?
      role.include?('students')
    end

    def students_by_specialties(criteria)
      criteria.joins(:student_profile).where('student_profiles.specialty_id' => params[:form_objects_mass_mailout][:specialty_ids])
    end

    def students_by_course_year(criteria)
      criteria.joins(:student_profile).where('student_profiles.course_year' => params[:form_objects_mass_mailout][:course_years])
    end

    def students_by_group(criteria)
      criteria.joins(:student_profile).where('student_profiles.group' => params[:form_objects_mass_mailout][:groups])
    end


  end
end
