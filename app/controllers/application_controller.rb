class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    current_user.present?
  end

  def current_account
    session[:account_id]    = params[:account_id] if params[:account_id]
    @current_account      ||= find_current_account
    session[:account_id]    = @current_account&.id
    @current_account
  end

  helper_method :current_account, :logged_in?

  private

  def find_current_account
    current_user.accounts.find(account_id)
  rescue ActiveRecord::RecordNotFound => e
    current_user.accounts.first
  end

  def account_id
    @account_id ||= session[:account_id]
  end
end
