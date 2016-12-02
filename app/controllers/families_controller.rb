class FamiliesController < ApplicationController
  def index

    # Get stories (when model is created)

    # Get parents (when model is ready)

    # Get children
    if current_user 
      @children = Child.where(user_id: current_user.id)

      render 'index.html.erb'
    else
      flash[:warning] = 'You must be logged in to view this page.'

      redirect_to '/users/sign_in'
    end
  end
end
