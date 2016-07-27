class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_or_guest_user)
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  private

  def redirect_to_back_or_default(default = root_url)
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

  def create_guest_user
    u = User.create(name: "Guest",
                    email: "guest_#{Time.now.to_i}#{rand(100)}@example.com",
                    guest: true)
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

end
