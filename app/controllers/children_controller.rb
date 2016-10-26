class ChildrenController < ApplicationController
  def new_profile
    unless user_signed_in?
      flash[:warning] = 'You must be logged in to use this feature.'
      redirect_to '/'
    end
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
      avatar: params[:avatar],
      user_id: params[:user_id]
    )
    @child.save
    redirect_to "/profile/#{@child.id}"
  end

  def show
    @child = Child.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def edit
    @child = Child.find_by(id: params[:id])
    render 'edit.html.erb'
  end

  def update_photo
    @child = Child.find_by(id: params[:id])
    @child.update(
      user_params
    )
    redirect_to "/profile/#{@child.id}"
  end

  def update
    @child = Child.find_by(id: params[:id])
    
    calculated_birth_date = params[:date_of_birth].blank? ? nil : Date.parse(params[:date_of_birth])
    calculated_death_date = params[:date_of_death].blank? ? nil : Date.parse(params[:date_of_death])

    @child.update(
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
    redirect_to "/profile/#{@child.id}"
  end

  def destroy
    @child = Child.find_by(id: params[:id])
    @child.destroy 
    redirect_to '/'
  end

  def register
    @child = Child.find_by(id: params[:id])
    render 'register.html.erb'
  end

  def confirm_register
    @child = Child.find_by(id: params[:id])
    @user = User.find_by(id: @child.user_id)
    @parent = Parent.new(
      first_name: params[:parent_1_first_name],
      last_name: params[:parent_1_last_name],
      city: params[:parent_1_city],
      state: params[:parent_1_state],
      phone_number: params[:parent_1_phone_number],
      email: params[:parent_1_email],
      relationship: params[:parent_1_relationship]
    )
    @parent.save
    @child.update(
      nickname: params[:child_nickname],
      birth_order: params[:child_birth_order],
      primary_diagnosis: params[:child_primary_diagnosis],
      secondary_diagnosis: params[:child_secondary_diagnosis],
      other_chrom_affected: params[:child_other_chrom_affected],
      mosaic_percentage: params[:child_mosaic_trisomy_percentage],
      arms_affected: params[:child_partial_trisomy]
    )
    @user.update(
      first_name: params[:user_first_name],
      last_name: params[:user_last_name],
      relationship: params[:user_relationship],
      phone_number: params[:user_phone_number]
    )
    redirect_to '/'
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:child).permit(:avatar)
  end
end
