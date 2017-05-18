# ProfessionalCenterController
class ProfessionalCenterController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.user_type == 'doctor' || current_user.user_type == "admin"
      render 'index.html.erb'
    else
      flash[:error] = 'You must be a doctor to use the Professional Center tool'
      redirect_to root_url
    end
  end
end
