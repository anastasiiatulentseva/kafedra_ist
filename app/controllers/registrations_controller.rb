class RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_specialties, only: [:new, :create, :edit]

  protected

  def get_specialties
    @specialties = Specialty.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :group, :specialty_id, :course_year])

    if current_or_guest_user.admin?
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :picture, :group, :course_year, :specialty_id, roles: [] ])
    else
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :picture, :group, :course_year, :specialty_id])
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

end
