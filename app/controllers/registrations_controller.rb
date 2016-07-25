class RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    if @user.admin?
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :picture, { roles:[] } ])
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

  def set_user
    @user = current_or_guest_user
  end
end
