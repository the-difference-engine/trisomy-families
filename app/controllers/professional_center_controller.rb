# ProfessionalCenterController
class ProfessionalCenterController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.user_type == 'doctor'
      render 'index.html.erb'
    else
      flash[:error] = 'You do not have access to this page. Please contact an admin.'
      redirect_to root_url
    end
  end
end
