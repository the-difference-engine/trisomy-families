class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :city, :state, :address, :phone_number, :user_type, :email, :password) }
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.user_type == "doctor"
      "/profile_doctor"
    elsif current_user.user_type == "family"
      "/profile/new"
    elsif current_user.user_type == "admin"
      "/admin-dashboard"
    end
  end
end
