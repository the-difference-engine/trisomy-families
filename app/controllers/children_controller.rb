class ChildrenController < ApplicationController
  def new_profile
  end

  def create_profile
    @child = Child.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      trisomy_type: params[:trisomy_type],
      birth_date: Date.parse(params[:date_of_birth]),
      death_date: Date.parse(params[:date_of_death]),
      state: params[:state],
      city: params[:city],
      trisomy_story: params[:trisomy_story],
      avatar: params[:avatar]
    )
    @child.save
    redirect_to "/profile/#{@child.id}"
  end

  def show
    @child = Child.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def update
    @child = Child.find_by(id: params[:id])
    @child.update(
      user_params
    )
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:child).permit(:avatar)
  end
end
