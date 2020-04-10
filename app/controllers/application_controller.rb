class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in_as_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in_as_admin?
    current_user && current_user.is_admin?
  end

  def authenticate_user!
    redirect_to "/" unless current_user
  end

  def authenticate_admin!
    redirect_to "/" unless logged_in_as_admin?
  end
end
