class ApplicationController < ActionController::Base
  helper_method :current_user

  before_action :authenticate_user!

  private

  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  rescue
    nil
  end

  def authenticate_user!
    unless current_user&.present?
      redirect_to login_path
    end
  end
end
