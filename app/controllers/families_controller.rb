class FamiliesController < ApplicationController
  def index

    # Get stories (when model is created)

    # Get parents (when model is ready)

    # Get children 
    @children = Child.where(user_id: current_user.id)

    render 'index.html.erb'
  end
end
