class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    current_user.present?
  end

  helper_method :logged_in?

  protected

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || dashboard_path
  end
end
