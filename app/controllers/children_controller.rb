class ChildrenController < ApplicationController
  def new
    @family = Family.find_by(id: current_user.family_id)
    unless user_signed_in?
      # @child.user_id = current_user.id
      flash[:warning] = 'You must be logged in to use this feature.'
      redirect_to '/'
    else
      @child = Child.new
      @child.user_id = current_user.id
      @child.build_privacy
      render 'new.html.erb'
    end
  end

  def create
    @child = Child.new(child_params)
    @child.birth_date = calculate_date(params[:child][:birth_date])
    @child.death_date = calculate_date(params[:child][:death_date])
    @child.user_id = current_user.id
    @child.build_privacy(privacy_params)
    @child.family_id = current_user.family_ids[0]

    #using add_photo method to allow initial photo upload
    #if no photo uploaded, default image will be set
    add_photo

    # byebug
    if @child.save
      flash[:success] = 'Profile created!'
      redirect_to "/profile/#{@child.id}"
    else
      render 'new.html.erb'
    end
  end

  def show    
    if user_signed_in?
      @child = Child.find_by(id: params[:id])
      @contact_form = ContactInfoForm.find_by(child_id: @child.id)

      render 'show.html.erb'
    else
      flash[:warning] = 'You must be logged in to use this feature.'
      redirect_to '/users/sign_in'
    end
  end

  def edit
    @child = Child.find_by(id: params[:id])
    @privacy = @child.privacy
    render 'edit.html.erb'
  end

  def add_photo
    if params[:child][:avatar_file_name]
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params[:child][:avatar_file_name].original_filename


      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params[:child][:avatar_file_name].tempfile.path)

      @child.avatar_file_name = obj.public_url
    end
  end

  def update_photo

    # Generate random string to file_name for uniqueness
    charset = Array('A'..'Z') + Array('a'..'z')
    random_string = Array.new(20) { charset.sample }.join
    object_name = random_string + '_' + params[:child][:avatar_file_name].original_filename

    obj = S3_BUCKET.object(object_name)
    obj.upload_file(params[:child][:avatar_file_name].tempfile.path)
<<<<<<< HEAD

    @child.avatar_file_name = obj.public_url

=======

    @child.avatar_file_name = obj.public_url

>>>>>>> 62f0045fe3cb99259a672040322271b6855d6d94
  end

  def update
    @child = Child.find_by(id: params[:id])
    @privacy = @child.privacy
    @child.assign_attributes(
      first_name: params["child"]["first_name"],
      last_name: params["child"]["last_name"],
      nickname: params["child"]["nickname"],
      trisomy_type: params["child"]["trisomy_type"],
      birth_date: calculate_date(params["child"]["birth_date"]),
      death_date: calculate_date(params["child"]["death_date"]),
      birth_order: params["child"]["birth_order"],
      primary_diagnosis: params["child"]["primary_diagnosis"],
      other_primary_diagnosis: params["child"]["other_primary_diagnosis"],
      state: params["child"]["state"],
      city: params["child"]["city"],
      trisomy_story: params["child"]["trisomy_story"]
    )

    @privacy.assign_attributes(
      story: params["child"]["privacy"]["story"],
      avatar: params["child"]["privacy"]["avatar"],
      location: params["child"]["privacy"]["location"],
      birthday: params["child"]["privacy"]["birthday"],
      trisomy_type: params["child"]["privacy"]["trisomy_type"]
    )

    if params[:child][:avatar_file_name]
      update_photo
    end

    if @child.save && @privacy.save
      flash[:success] = 'Profile Updated!'
      redirect_to "/profile/#{@child.id}"
    else
      render 'edit.html.erb'
    end
      
  end

  def destroy
    @child = Child.find_by(id: params[:id])
    @child.destroy
    redirect_to '/family-dashboard'
  end


  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:child).permit(:avatar, :private)
  end

  def child_params
    params.require(:child).permit(:first_name,
                                  :last_name,
                                  :trisomy_type,
                                  :address,
                                  :city,
                                  :state,
                                  :trisomy_story,
                                  :nickname,
                                  :birth_order,
                                  :primary_diagnosis,
                                  :other_primary_diagnosis)
  end

  def privacy_params
    if params[:child][:privacy_attributes] != nil
      return { avatar: params[:child][:privacy_attributes][:avatar],
              location: params[:child][:privacy_attributes][:location],
              birthday: params[:child][:privacy_attributes][:birthday],
              trisomy_type: params[:child][:privacy_attributes][:trisomy_type],
              story: params[:child][:privacy_attributes][:story] }
    else
      return { avatar: nil,
              location: nil,
              birthday: nil,
              trisomy_type: nil,
              story: nil }
    end
  end

  def calculate_date(date_param)
    date_param.blank? ? nil : Date.parse(date_param)
  end
end
