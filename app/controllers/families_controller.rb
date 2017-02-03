class FamiliesController < ApplicationController
  def index
    # Get stories (when model is created)

    # Get parents (when model is ready)

    # Get children
    if current_user
      @children = Child.where(user_id: current_user.id)
      if @children.count == 0
        flash[:warning] = 'You must have registered family members to view the family dashboard.'
        redirect_to '/profile/new'

      else
        @children.each do |child|
          @parents = Parent.where(id: child.parent_id)
         end
         render 'index.html.erb'
      end

    else
      flash[:warning] = 'You must be logged in to view this page.'

      redirect_to '/users/sign_in'

    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render 'show.html.erb'
  end
end
