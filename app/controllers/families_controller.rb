class FamiliesController < ApplicationController
  def index

    # Get parents
    # Get children through parents

    @children = Child.where(user_id: current_user.id)

    render 'index.html.erb'
  end
end
