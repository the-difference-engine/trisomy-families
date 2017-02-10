class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :city, :state, :phone_number, :user_type, :email, :password) }
  end
end
