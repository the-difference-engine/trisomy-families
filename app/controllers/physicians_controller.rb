class PhysiciansController < ApplicationController
  def new_profile
    @physician = Physician.new
    render 'physician_create_profile_page.html.erb'
  end

  def create_profile
    @physician = Physician.new(physician_params)
    if @physician.save
      flash[:success] = 'Profile created!'
      redirect_to "/profile_doctor/#{@physician.id}"
    else
      render 'physician_create_profile_page.html.erb'
    end
  end

  def physician_params
    params.require(:physician).permit(
      :first_name,
      :last_name,
      :personal_number,
      :primary_phone_public,
      :address,
      :phone_number,
      :state, :city,
      :zip_code,
      :website,
      :speciality
    )
  end

  def show
    @physician = Physician.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def edit
    if current_user.user_type == 'doctor' || current_user.user_type == 'admin'
      @physician = Physician.find_by(id: params[:id])
      render 'edit.html.erb'
    else
      flash[:warning] = 'You must be a doctor to edit this page!'
      redirect_to '/'
    end
  end

  def update
    @physician = Physician.find_by(id: params[:id])

    @physician.update(
      first_name: params[:first_name] || @physician.first_name,
      last_name: params[:last_name] || @physician.last_name,
      phone_number: params[:phone_number] || @physician.phone_number,
      address: params[:address] || @physician.address,
      state: params[:state] || @physician.state,
      city: params[:city] || @physician.city,
      zip_code: params[:zip_code] || @physician.zip_code,
      website: params[:website] || @physician.website,
      speciality: params[:speciality] || @physician.speciality
    )
    if @physician.save
      flash[:success] = 'Profile Updated!'
    else
      flash[:warning] = 'Error!'
    end
    redirect_to "/profile_doctor/#{@physician.id}"
  end
end