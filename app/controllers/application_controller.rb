class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate_user!
    unless logged_in?
      flash[:error] = "Tu dois être connecté pour accéder à cette page."
      redirect_to login_path
    end
  end
end



