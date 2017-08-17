class ChildrenController < ApplicationController
  def new
    @family = Family.find_by(id: current_user.family_id)
    unless user_signed_in?
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
    if current_user
      @child = Child.new(child_params)
      @child.birth_date = calculate_date(params["child"]["birth_date(1i)"], params["child"]["birth_date(2i)"], params["child"]["birth_date(3i)"])
      @child.death_date = calculate_date(params["child"]["death_date(1i)"], params["child"]["death_date(2i)"], params["child"]["death_date(3i)"])
      if params[:not_applicable] == "n/a"
        @child.other_chrom_affected = ""
      end
      if params[:child][:primary_diagnosis] == 'Mosaic'
        @child.mosaic_percentage = params[:child][:mosaic_percentage]
        @child.partial_trisomy = nil
      elsif params[:child][:primary_diagnosis] == 'Partial'
        @child.partial_trisomy = params[:child][:partial_trisomy]
        @child.mosaic_percentage = nil
      else
        @child.mosaic_percentage = nil
        @child.partial_trisomy = nil
      end

      if params[:not_applicable_2] == "n/a"
        @child.secondary_diagnosis = ""
        @child.other_secondary_diagnosis = ""
        @child.secondary_mosaic_percentage = nil
        @child.secondary_partial_trisomy = nil
      elsif params[:child][:secondary_diagnosis] == 'Mosaic'
        @child.secondary_mosaic_percentage = params[:child][:secondary_mosaic_percentage]
        @child.secondary_partial_trisomy = nil
      elsif params[:child][:secondary_diagnosis] == 'Partial'
        @child.secondary_partial_trisomy = params[:child][:secondary_partial_trisomy]
        @child.secondary_mosaic_percentage = nil
      else
        @child.secondary_mosaic_percentage = nil
        @child.secondary_partial_trisomy = nil
      end
      @child.user_id = current_user.id
      @child.build_privacy(privacy_params)
      @child.family_id = current_user.family_ids[0]

      #using add_photo method to allow initial photo upload
      #if no photo uploaded, default image will be set
      add_photo

      # byebug
      if @child.save
        flash[:success] = "#{@child.full_name} was successfully created!"
        redirect_to "/profile/#{@child.id}"
      else
        render 'new.html.erb'
      end
    else
      flash[:warning] = "You do not have permission to view that page."
      redirect_to "/"
    end
  end

  def show    
    @child = Child.find_by(id: params[:id])   

    if current_user
      my_family = Family.find_by(user_id: current_user.id)
      if @child != nil 
        @child.privacy.attributes.values[2..-3].select {|value| value == false}.count > 1 ? child_privacy = false : child_privacy = true
      end

      if current_user.user_type == "doctor"
        flash[:danger] = "Your account does not have access to that page"
        redirect_back(fallback_location: root_path)
      elsif !@child
        flash[:danger] = "That profile does not exist"
        redirect_back(fallback_location: root_path)
      elsif my_family  
        registered = false      
        my_family.children.each do |child|
          if child.accepted
            registered = true
            break
          end
        end
        if ((registered || current_user.user_type == "admin") && child_privacy == false) || my_family.id == @child.family_id
          @contact_form = ContactInfoForm.find_by(child_id: @child.id)
          @family = Family.find_by(id: @child.family_id)
          render 'show.html.erb'
        elsif (child_privacy == true && current_user.user_type != "admin") ||  !registered
          flash[:danger] = "Un-registered users do not have access to view profiles"
          redirect_back(fallback_location: root_path)
        else
          flash[:danger] = "That page is set to private"
          redirect_back(fallback_location: root_path)
        end          
      else        
        @contact_form = ContactInfoForm.find_by(child_id: @child.id)
        @family = Family.find_by(id: @child.family_id)
        render 'show.html.erb'
      end
    else
      if child_privacy == true
        flash[:danger] = "That page is set to private"
        redirect_back(fallback_location: root_path)
      else
        @contact_form = ContactInfoForm.find_by(child_id: @child.id)
        @family = Family.find_by(id: @child.family_id)
        render 'show.html.erb' 
      end
    end
  end

  def edit    
    @child = Child.find_by(id: params[:id])
    if !@child 
      flash[:danger] = "Profile does not exist"
      redirect_back(fallback_location: root_path)
    elsif !current_user
      flash[:danger] = "You must be logged in to view that page!"
      redirect_back(fallback_location: root_path)
    elsif current_user == "doctor"
      flash[:danger] = "You do not have access to that page because you are a doctor-type user."
      redirect_back(fallback_location: root_path)
    else
      my_family = Family.find_by(user_id: current_user.id)
      if current_user.user_type == "admin" || @child.family_id == my_family.id
        @privacy = @child.privacy
        render 'edit.html.erb'
      else 
        flash[:danger] = "You are not authorized to view that page!"
        redirect_back(fallback_location: root_path)
      end   
    end
    
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
    @child = Child.find_by(id: params[:id])
    # Generate random string to file_name for uniqueness
    charset = Array('A'..'Z') + Array('a'..'z')
    random_string = Array.new(20) { charset.sample }.join
    object_name = random_string + '_' + params[:child][:avatar_file_name].original_filename

    obj = S3_BUCKET.object(object_name)
    obj.upload_file(params[:child][:avatar_file_name].tempfile.path)

    @child.update_columns(avatar_file_name: obj.public_url)

    if @child.save
      flash[:success] = "#{@child.full_name} was successfully updated!"
    else
      flash[:error] = "Error occured in uploading file."
    end
    redirect_to "/profile/#{@child.id}"
  end

  def update
    @child = Child.find_by(id: params[:id])
    @privacy = @child.privacy
    @child.assign_attributes(
      first_name: params["child"]["first_name"],
      last_name: params["child"]["last_name"],
      nickname: params["child"]["nickname"],
      trisomy_type: params["child"]["trisomy_type"],
      birth_date: calculate_date(params["child"]["birth_date(1i)"], params["child"]["birth_date(2i)"], params["child"]["birth_date(3i)"]),
      death_date: calculate_date(params["child"]["death_date(1i)"], params["child"]["death_date(2i)"], params["child"]["death_date(3i)"]),
      birth_order: params["child"]["birth_order"],
      primary_diagnosis: params["child"]["primary_diagnosis"],
      secondary_diagnosis: params["child"]["secondary_diagnosis"],
      other_primary_diagnosis: params["child"]["other_primary_diagnosis"],
      other_secondary_diagnosis: params["child"]["other_primary_diagnosis"],
      other_chrom_affected: params["child"]["other_chrom_affected"],
      trisomy_story: params["child"]["trisomy_story"]
    )
    
    if params[:not_applicable] == "n/a"
      @child.other_chrom_affected = ""
    end
    if params[:child][:primary_diagnosis] == 'Mosaic'
      @child.mosaic_percentage = params[:child][:mosaic_percentage]
      @child.partial_trisomy = nil
    elsif params[:child][:primary_diagnosis] == 'Partial'
      @child.partial_trisomy = params[:child][:partial_trisomy]
      @child.mosaic_percentage = nil
    else
      @child.mosaic_percentage = nil
      @child.partial_trisomy = nil
    end

    if params[:not_applicable_2] == "n/a"
      @child.secondary_diagnosis = ""
      @child.other_secondary_diagnosis = ""
      @child.secondary_mosaic_percentage = nil
      @child.secondary_partial_trisomy = nil
    elsif params[:child][:secondary_diagnosis] == 'Mosaic'
      @child.secondary_mosaic_percentage = params[:child][:secondary_mosaic_percentage]
      @child.secondary_partial_trisomy = nil
    elsif params[:child][:secondary_diagnosis] == 'Partial'
      @child.secondary_partial_trisomy = params[:child][:secondary_partial_trisomy]
      @child.secondary_mosaic_percentage = nil
    else
      @child.secondary_mosaic_percentage = nil
      @child.secondary_partial_trisomy = nil
    end

    @privacy.assign_attributes(
      story: params["child"]["privacy_attributes"]["story"],
      avatar: params["child"]["privacy_attributes"]["avatar"],
      location: params["child"]["privacy_attributes"]["location"],
      birthday: params["child"]["privacy_attributes"]["birthday"],
      trisomy_type: params["child"]["privacy_attributes"]["trisomy_type"]
    )

    if params[:child][:avatar_file_name]
      update_photo
    end

    if @child.save && @privacy.save
      flash[:success] = "#{@child.full_name} was successfully updated!"
      redirect_to "/registrations/#{@child.id}"
    else
      render 'edit.html.erb'
    end
      
  end

  def destroy
    @child = Child.find_by(id: params[:id])
    @privacy = Privacy.find_by(child_id: @child.id)
    @contact_info = ContactInfoForm.find_by(child_id: @child.id)
    @background_history = BackgroundHistory.find_by(id: @child.background_history_id)
    @health_history = HealthHistory.find_by(id: @child.health_history_id)
    if @contact_info != nil
      @contact_info.destroy
    end
    if @health_history != nil
      if @health_history.chd_id != nil
        @congenital_heart_defect = CongenitalHeartDefect.find_by(id: @health_history.chd_id)
        @congenital_heart_defect.destroy
      end
      if @health_history.intestinal_issues_id != nil
        @intestinal_issue = IntestinalIssue.find_by(id: @health_history.intestinal_issues_id)
        @intestinal_issue.destroy
      end
      if @health_history.gastric_surgery_id != nil
        @gastric_surgery = GastricSurgery.find_by(id: @health_history.gastric_surgery_id)
        @gastric_surgery.destroy
      end
      if @health_history.nuerological_condition_id != nil
        @neurological_condition = NuerologicalCondition.find_by(id: @health_history.nuerological_condition_id)
        @neurological_condition.destroy
      end
      if @health_history.muscular_skeletal_id != nil
        @muscular_skeletal = MuscularSkeletal.find_by(id: @health_history.muscular_skeletal_id)
        @muscular_skeletal.destroy
      end
      if @health_history.cranial_facial_id != nil
        @cranial_facial = CranialFacial.find_by(id: @health_history.cranial_facial_id)
        @cranial_facial.destroy
      end
      if @health_history.endocrine_id != nil
        @endocrine = Endocrine.find_by(id: @health_history.endocrine_id)
        @endocrine.destroy
      end
      if @health_history.hearing_id != nil
        @hearing = Hearing.find_by(id: @health_history.hearing_id)
        @hearing.destroy
      end
      if @health_history.vision_id != nil
        @vision = Vision.find_by(id: @health_history.vision_id)
        @vision.destroy
      end
      if @health_history.behavioral_health_id != nil
        @behavioral_health = BehavioralHealth.find_by(id: @health_history.behavioral_health_id) 
        @behavioral_health.destroy
      end
      if @health_history.received_therapy_id != nil
        @received_therapy = ReceivedTherapy.find_by(id: @health_history.received_therapy_id)
        @received_therapy.destroy
      end
      @health_history.destroy
    end
    if @background_history != nil
      if @background_history.mother_complication_id != nil
        @mother_complications = MotherComplication.find_by(id: @background_history.mother_complication_id)
        @mother_complications.destroy
      end
      if @background_history.weight_id != nil
        @weight = Weight.find_by(id: @background_history.weight_id)
        @weight.destroy
      end
      if @background_history.height_id != nil
        @height = Height.find_by(id: @background_history.height_id)
        @height.destroy
      end
      if @background_history.head_circumference_id != nil
        @head_circumference = HeadCircumference.find_by(id: @background_history.head_circumference_id)
        @head_circumference.destroy
      end
      @background_history.destroy
    end
    if @child.destroy && @privacy.destroy
      flash[:success] = "#{@child.full_name} was successfully deleted."
      redirect_to "/families/#{@child.family_id}"
    end
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
                                  :trisomy_story,
                                  :nickname,
                                  :birth_order,
                                  :primary_diagnosis,
                                  :secondary_diagnosis,
                                  :other_chrom_affected,
                                  :other_primary_diagnosis,
                                  :other_secondary_diagnosis)
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

  def calculate_date(month, day, year)
    month.blank? || day.blank? || year.blank? ? nil : DateTime.new(month.to_i, day.to_i, year.to_i)
  end
end
