class ChildrenController < ApplicationController
  def new_profile
  end

  def create_profile
    calculated_birth_date = params[:date_of_birth].blank? ? nil : Date.parse(params[:date_of_birth])
    calculated_death_date = params[:date_of_death].blank? ? nil : Date.parse(params[:date_of_death])

    @child = Child.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      trisomy_type: params[:trisomy_type],
      birth_date: calculated_birth_date,
      death_date: calculated_death_date,
      state: params[:state],
      city: params[:city],
      trisomy_story: params[:trisomy_story],
      avatar: params[:avatar]
    )
    @child.save
    redirect_to '/'
  end
end
