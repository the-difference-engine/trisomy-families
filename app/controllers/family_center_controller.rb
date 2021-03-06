class FamilyCenterController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.user_type == "doctor"
      flash[:danger] = 'Your account does not have access to view that page'
      redirect_to '/'
    elsif current_user.user_type == "family"

      my_family = Family.find_by(user_id: current_user.id)
      registered = false      
      if my_family != nil
        my_family.children.each do |child|
          if child.accepted
            registered = true
          end
        end
      end

      if registered
        render 'index.html.erb'
      else
        flash[:danger] = "You must have at least one fully registered trisomy participant in order to view that page"
        redirect_to(:back)
      end
    else            
      render 'index.html.erb'
    end
  end
end
