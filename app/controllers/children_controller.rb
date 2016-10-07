class ChildrenController < ApplicationController
  def new_profile
  end

  def create_profile
    # bday = DateTime.parse(params[:date_of_birth])
    # dday = DateTime.parse(params[:date_of_death])
    @child = Child.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      trisomy_type: params[:trisomy_type],
      state: params[:state],
      city: params[:city],
      trisomy_story: params[:trisomy_story]
    )
    @child.save
    redirect_to '/'
  end
end
