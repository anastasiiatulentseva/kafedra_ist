class RegistrationsController < Devise::RegistrationsController


  protected

  def update_resource(recource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
