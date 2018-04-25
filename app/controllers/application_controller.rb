class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    current_user.present?
  end

  helper_method :logged_in?
end
