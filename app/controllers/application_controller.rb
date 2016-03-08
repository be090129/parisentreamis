class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def only_admin
    if !current_user || (current_user && !current_user.is_admin)
      flash[:error] = "You must be logged as admin to access this section"
      redirect_to root_path
    end
  end



  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :remember_me, :name, :is_admin) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,:current_password, :remember_me, :name, :is_admin) }
  end
end
