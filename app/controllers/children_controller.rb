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
      trisomy_story: params[:trisomy_story]
    )
    @child.save
    redirect_to '/'
  end
end
