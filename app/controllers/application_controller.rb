class ApplicationController < ActionController::Base
  layout :logged_in?
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :city, :state, :address, :phone_number, :user_type, :email, :password) }
  end

  def after_sign_in_path_for(resource_or_scope)

    if current_user.user_type == 'family'
      family = Family.find_by(user_id: current_user.id)
      if family
        "/families/#{family.id}"
      else
        @family = Family.new
        "/families/new"
      end
    elsif current_user.user_type == 'doctor'
        doctor = Physician.find_by(user_id: current_user.id)
        if doctor
          "/profile_doctor/#{doctor.id}"
        else
          "/profile_doctor"
        end
    elsif current_user.user_type == "admin"
      "/admin-dashboard"
    end

  end

  private
  def logged_in?
    if user_signed_in?
      "application"
    else
      "fullscreen"
    end
  end
end
