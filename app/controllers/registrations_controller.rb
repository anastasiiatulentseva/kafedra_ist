class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    if current_or_guest_user.admin?
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :picture, roles: [] ])
    else
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :picture ])
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

end
