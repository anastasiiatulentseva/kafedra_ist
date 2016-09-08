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

        criteria = students_by_specialties(criteria) if specialties.present?
        criteria = students_by_course_year(criteria) if course_years.present?
        criteria = students_by_group(criteria) if groups.present?

        criteria
      elsif teachers?
        User.with_role(:teacher)
      else
        User.active
      end
    end

    private

    def mailout_params
      params[:form_objects_mass_mailout]
    end

    def role
      mailout_params[:role]
    end

    def specialties
      mailout_params[:specialty_ids]
    end

    def groups
      mailout_params[:groups]
    end

    def course_years
      mailout_params[:course_years]
    end

    def teachers?
      role.include?('teachers')
    end

    def students?
      role.include?('students')
    end

    def students_by_specialties(criteria)
      criteria.joins(:student_profile).where('student_profiles.specialty_id' => specialties)
    end

    def students_by_course_year(criteria)
      criteria.joins(:student_profile).where('student_profiles.course_year' => course_years)
    end

    def students_by_group(criteria)
      criteria.joins(:student_profile).where('student_profiles.group' => groups)
    end

  end
end
