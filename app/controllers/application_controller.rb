class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    current_user.present?
  end

  def current_company
    @current_company      ||= find_current_company
    session[:company_id]    = @current_company&.id
    @current_company
  end

  helper_method :current_company, :logged_in?

  private

  def find_current_company
    Company.find(company_id)
  rescue ActiveRecord::RecordNotFound => e
    current_user.companies.first
  end

  def company_id
    @company_id ||= session[:company_id]
  end
end
