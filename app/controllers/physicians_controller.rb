class PhysiciansController < ApplicationController
  def new_profile
    @physician = Physician.new()
    render 'physician_create_profile_page.html.erb'
  end

  def create_profile
    @physician = Physician.new(physician_params)
    if @physician.save
      flash[:success] = 'Profile created!'
      redirect_to "/profile_doctor/#{@physician.id}"
    else
      render 'new_profile.html.erb'
    end
  end

  def physician_params
    params.require(:physician).permit(
      :first_name,
      :last_name,
      :phone_number,
      :address,
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
end
