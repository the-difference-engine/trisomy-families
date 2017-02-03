class ProfessionalCenterController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      if current_user.user_type == "admin" || current_user.user_type == "doctor"
        @children = Unirest.get('http://localhost:3000/api/v1/children.json').body
        render 'index.html.erb'
      else
        flash[:error] = "You do not have access to this page. Please contact an admin."
        redirect_to "/"  
      end  
    end  
  end
end
