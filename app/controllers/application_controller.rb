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
      if current_user.families != []
        family = current_user.families[0].id
        "/families/#{family}"
      else
        "family/new"
      end

    end






    # if current_user.user_type == 'family' && current_user.families[0] != nil
    #   "/families/#{current_user.families[0].id}"
    # elsif current_user.user_type == "doctor"
    #   "/profile_doctor"
    # elsif current_user.user_type == "family" && my_family.ids[0] == nil
    #   "/families/new"
    # elsif current_user.user_type == "admin"
    #   "/admin-dashboard"
    # end

    # my_family = Family.where(user_id: current_user.id)
    # if current_user.user_type == 'family' && my_family.ids[0] != nil
    #   "/families/#{my_family.ids[0]}"
    # elsif current_user.user_type == "doctor"
    #   "/profile_doctor"
    # elsif current_user.user_type == "family" && my_family.ids[0] == nil
    #   "/families/new"
    # elsif current_user.user_type == "admin"
    #   "/admin-dashboard"
    # end
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
