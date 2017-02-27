class ApplicationController < ActionController::Base
  layout :logged_in?
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :city, :state, :phone_number, :email, :password) }
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
