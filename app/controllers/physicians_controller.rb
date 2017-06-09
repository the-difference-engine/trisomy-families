class PhysiciansController < ApplicationController
  def new
    if current_user.user_type == 'admin' || current_user.user_type == 'doctor'
      @physician = Physician.new
    else
      flash[:warning] = 'You need to be an admin or doctor to see this page!'
      redirect_to '/'
    end
  end

  def create
    @physician = Physician.new(physician_params)

    if @physician.save

      flash[:success] = 'Profile created!'
      redirect_to "/physicians/#{@physician.id}"
    else
      redirect_to '/physicians/new'
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
      :specialty,
      :user_id
    )
  end

  def show
    @physician = Physician.find(params[:id])

    if current_user.user_type == 'admin' || current_user.id == @physician.user_id || current_user.family_id
      render 'show.html.erb'
    else
      flash[:warning] = 'You need to be an admin, the actual physician, or have registered your family to see this page!'
      redirect_to '/'
    end
  end

  def edit
    @physician = Physician.find_by(id: params[:id])
    if current_user.id == @physician.user_id || current_user.user_type == 'admin'
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
      specialty: params[:specialty] || @physician.specialty,
      user_id: current_user.id
    )
    if @physician.save
      flash[:success] = 'Profile Updated!'
    else
      flash[:warning] = 'Error!'
    end
    redirect_to "/physicians/#{@physician.id}"
  end

  def update_photo
    @physician = Physician.find_by(id: params[:id])

    # Generate random string to file_name for uniqueness
    charset = Array('A'..'Z') + Array('a'..'z')
    random_string = Array.new(20) { charset.sample }.join
    object_name = random_string + '_' + params[:physician][:avatar].original_filename

    obj = S3_BUCKET.object(object_name)
    obj.upload_file(params[:physician][:avatar].tempfile.path)

    @physician.update_columns(avatar_file_name: obj.public_url)

    if @physician.save
      flash[:message] = "Uploaded succesfully."
    else
      flash[:error] = "Error occured in uploading file."
    end

    redirect_to "/physicians/#{@physician.id}"
  end
end
