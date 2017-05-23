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
    @child = Child.find_by(id: params[:id])

    # Generate random string to file_name for uniqueness
    charset = Array('A'..'Z') + Array('a'..'z')
    random_string = Array.new(20) { charset.sample }.join
    object_name = random_string + '_' + params[:child][:avatar].original_filename

    obj = S3_BUCKET.object(object_name)
    obj.upload_file(params[:child][:avatar].tempfile.path)

    @child.update_columns(avatar_file_name: obj.public_url)

    if @child.save
      flash[:message] = "Uploaded succesfully."
    else
      flash[:error] = "Error occured in uploading file."
    end

    redirect_to "/profile/#{@child.id}"
  end

  def update
    @child = Child.find_by(id: params[:id])
    @privacy = @child.privacy

    @child.update(
      first_name: params[:first_name] || @child.first_name,
      last_name: params[:last_name] || @child.last_name,
      trisomy_type: params[:trisomy_type] || @child.trisomy_type,
      birth_date: calculate_date(params[:date_of_birth]) || @child.birth_date,
      death_date: calculate_date(params[:date_of_death]) || @child.death_date,
      state: params[:state] || @child.state,
      city: params[:city] || @child.city,
      trisomy_story: params[:trisomy_story] || @child.trisomy_story
    )

    @privacy.update(
      story: params[:story] || @privacy.story,
      avatar: params[:avatar] || @privacy.avatar,
      location: params[:location] || @privacy.location,
      birthday: params[:birthday] || @privacy.birthday,
      trisomy_type: params[:trisomy_type] || @privacy.trisomy_type
    )

    if @child.save
      flash[:success] = 'Profile Updated!'
    end
    redirect_to "/profile/#{@child.id}"
  end

  def destroy
    @child = Child.find_by(id: params[:id])
    @child.destroy
    redirect_to '/family-dashboard'
  end

  def register
    @user = current_user
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
      relationship: params[:parent_1_relationship],
      child_id: @child.id,
      first_name_2: params[:parent_2_first_name],
      last_name_2: params[:parent_2_last_name],
      city_2: params[:parent_2_city],
      state_2: params[:parent_2_state],
      phone_number_2: params[:parent_2_phone_number],
      email_2: params[:parent_2_email],
      relationship_2: params[:parent_2_relationship]
    )
    @child.update(
      nickname: params[:child_nickname],
      birth_order: params[:child_birth_order],
      primary_diagnosis: params[:child_primary_diagnosis],
      other_primary_diagnosis: params[:other_primary_diagnosis],
      secondary_diagnosis: params[:child_secondary_diagnosis],
      other_secondary_diagnosis: params[:other_secondary_diagnosis],
      other_chrom_affected: params[:child_other_chrom_affected],
      mosaic_percentage: params[:child_mosaic_trisomy_percentage],
      partial_trisomy: params[:child_partial_trisomy],
      parent_id: @parent.id,
      registered: true
    )
    @user.update(
      first_name: params[:user_first_name],
      last_name: params[:user_last_name],
      relationship: params[:user_relationship],
      phone_number: params[:user_phone_number],
      city: params[:user_city],
      state: params[:user_state]
    )
    if @parent.save &&
       @child.update(
         nickname: params[:child_nickname],
         birth_order: params[:child_birth_order],
         primary_diagnosis: params[:child_primary_diagnosis],
         other_primary_diagnosis: params[:other_primary_diagnosis],
         secondary_diagnosis: params[:child_secondary_diagnosis],
         other_secondary_diagnosis: params[:other_secondary_diagnosis],
         other_chrom_affected: params[:child_other_chrom_affected],
         mosaic_percentage: params[:child_mosaic_trisomy_percentage],
         partial_trisomy: params[:child_partial_trisomy],
         parent_id: @parent.id
       ) &&
       @user.update(
         first_name: params[:user_first_name],
         last_name: params[:user_last_name],
         relationship: params[:user_relationship],
         phone_number: params[:user_phone_number]
       )
      flash[:success] = "Profile Registered!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Profile could not be registered!"
      render 'register.html.erb'
    end
  end

  def edit_registration
    @child = Child.find_by(id: params[:id])
    @user = User.find_by(id: @child.user_id)
    @parent = Parent.find_by(child_id: @child.id)
    render 'edit_registration.html.erb'
  end

  def update_registration
    @child = Child.find_by(id: params[:id])
    @user = User.find_by(id: @child.user_id)
    @parent = Parent.find_by(child_id: @child.id)
    if
      @parent.update(
        first_name: params[:parent_1_first_name],
        last_name: params[:parent_1_last_name],
        city: params[:parent_1_city],
        state: params[:parent_1_state],
        phone_number: params[:parent_1_phone_number],
        email: params[:parent_1_email],
        relationship: params[:parent_1_relationship],
        first_name_2: params[:parent_2_first_name],
        last_name_2: params[:parent_2_last_name],
        city_2: params[:parent_2_city],
        state_2: params[:parent_2_state],
        phone_number_2: params[:parent_2_phone_number],
        email_2: params[:parent_2_email],
        relationship_2: params[:parent_2_relationship]
      ) &&
      @child.update(
        nickname: params[:child_nickname],
        birth_order: params[:child_birth_order],
        primary_diagnosis: params[:child_primary_diagnosis],
        secondary_diagnosis: params[:child_secondary_diagnosis],
        other_chrom_affected: params[:child_other_chrom_affected],
        mosaic_percentage: params[:child_mosaic_trisomy_percentage],
        partial_trisomy: params[:child_partial_trisomy]
      ) &&
      @user.update(
        first_name: params[:user_first_name],
        last_name: params[:user_last_name],
        relationship: params[:user_relationship],
        phone_number: params[:user_phone_number]
      )
      flash[:success] = "Profile Updated!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Profile could not be updated!"
      render 'edit_registration.html.erb'
    end
  end

  def add_background
    @child = Child.find_by(id: params[:id])
    @mother_complications = MotherComplication.new
    @weight = Weight.new
    @height = Height.new
    @head_circumference = HeadCircumference.new
    @background_history = BackgroundHistory.new
    render 'add_background.html.erb'
  end

  def background_history
    @child = Child.find_by(id: params[:id])
    @mother_complications = MotherComplication.new(
      gestational_diabetes: params[:gestational_diabetes],
      preeclampsia: params[:preeclampsia],
      clampsia: params[:clampsia],
      rh_factor: params[:rh_factor],
      separated_placenta: params[:separated_placenta],
      unsure: params[:unsure],
      extra_fluid: params[:extra_fluid],
      other: params[:other_complications]
    )
    @mother_complications.save

    months = @child.current_age
    years = months / 12

    if months
      
      numbers = ['one', 'two', 'three', 'four', 'five', 'six']
      @height = Height.new()
      @weight = Weight.new()
      @head_circumference = HeadCircumference.new()

      if months < 12
        i = 0
        while i < 6
          key_name = (numbers[i] + '_month').to_sym
          height_name = ('height_' + numbers[i] + '_month').to_sym
          weight_name = (numbers[i] + '_month').to_sym
          head_circumference_name = ('hc_' + numbers[i] + '_month').to_sym
          @height.write_attribute(key_name, params[height_name])
          @weight.write_attribute(key_name, params[weight_name])
          @head_circumference.write_attribute(key_name, params[head_circumference_name])
          i += 1
        end
        @height.save
      elsif months >= 12
        i = 0
        j = 0
        while i < 6
          key_name = (numbers[i] + '_month').to_sym
          height_name = ('height_' + numbers[i] + '_month').to_sym
          weight_name = (numbers[i] + '_month').to_sym
          head_circumference_name = ('hc_' + numbers[i] + '_month').to_sym
          @height.write_attribute(key_name, params[height_name])
          @weight.write_attribute(key_name, params[weight_name])
          @head_circumference.write_attribute(key_name, params[head_circumference_name])
          i += 1
        end
        if months > 18
          @height.write_attribute(:eighteen_month, params[:height_eighteen_month])
          @weight.write_attribute(:eighteen_month, params[:eighteen_month])
          @head_circumference.write_attribute(:eighteen_month, params[:hc_eighteen_month])
        end
        while j < years
          string_year = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen', 'twenty', 'twentyone', 'twentytwo', 'twentythree', 'twentyfour', 'twentyfive', 'twentysix', 'twentyseven', 'twentyeight', 'twentynine', 'thirty', 'thirtyone', 'thirtytwo', 'thirtythree', 'thirtyfour', 'thirtyfive', 'thirtysix', 'thirtyseven', 'thirtyeight', 'thirtynine', 'forty']
          key_name = (string_year[j] + '_year').to_sym
          height_name = ('height_' + string_year[j] + '_year').to_sym
          weight_name = (string_year[j] + '_year').to_sym
          head_circumference_name = ('hc_' + string_year[j] + '_year').to_sym
          @height.write_attribute(key_name, params[height_name])
          @weight.write_attribute(key_name, params[weight_name])
          @head_circumference.write_attribute(key_name, params[head_circumference_name])

          j += 1
        end
        
        @height.save
        @weight.save
        @head_circumference.save
      end
    end

    @background_history = BackgroundHistory.new(
      weight_at_birth: params[:weight_at_birth],
      height_at_birth: params[:height_at_birth],
      head_circumference_at_birth: params[:head_circumference_at_birth],
      delivery_method: params[:delivery_method],
      offered_c_section: params[:offered_c_section],
      child_complication: params[:child_complications],
      apgar_score: params[:apgar_scores],
      gestation_age: params[:gestation_age],
      mother_age_at_birth: params[:mother_age_at_birth],
      father_age_at_birth: params[:father_age_at_birth],
      multiple_birth: params[:multiple_birth],
      multiple_birth_trisomy: params[:multiple_birth_trisomy],
      siblings_with_trisomy: params[:siblings_with_trisomy],
      trisomy_relative: params[:trisomy_relative],
      mother_complication_id: @mother_complications.id,
      head_circumference_id: @head_circumference.id,
      weight_id: @weight.id,
      height_id: @height.id
    )
    @background_history.save
    if @mother_complications.save &&
       @weight.save &&
       @height.save &&
       @head_circumference.save &&
       @background_history.save &&
       @child.update(
         background_history_id: @background_history.id
       )
      flash[:success] = "Background History Successfully added!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Unable to add Background History!"
      render 'add_background.html.erb'
    end
  end

  def edit_background_history
    @child = Child.find_by(id: params[:id])
    @background_history = BackgroundHistory.find_by(id: @child.background_history_id)
    @mother_complications = MotherComplication.find_by(id: @background_history.mother_complication_id)
    @weight = Weight.find_by(id: @background_history.weight_id)
    @height = Height.find_by(id: @background_history.height_id)
    @head_circumference = HeadCircumference.find_by(id: @background_history.head_circumference_id)
    render 'edit_background_history.html.erb'
  end

  def update_background_history
    @child = Child.find_by(id: params[:id])
    @background_history = BackgroundHistory.find_by(id: @child.background_history_id)
    @mother_complications = MotherComplication.find_by(id: @background_history.mother_complication_id)
    @weight = Weight.find_by(id: @background_history.weight_id)
    @height = Height.find_by(id: @background_history.height_id)
    @head_circumference = HeadCircumference.find_by(id: @background_history.head_circumference_id)

    months = @child.current_age
    years = months / 12

    if months
      
      numbers = ['one', 'two', 'three', 'four', 'five', 'six']
      @height = Height.new()
      @weight = Weight.new()
      @head_circumference = HeadCircumference.new()

      if months < 12
        i = 0
        while i < 6
          key_name = (numbers[i] + '_month').to_sym
          height_name = ('height_' + numbers[i] + '_month').to_sym
          weight_name = (numbers[i] + '_month').to_sym
          head_circumference_name = ('hc_' + numbers[i] + '_month').to_sym
          @height.write_attribute(key_name, params[height_name])
          @weight.write_attribute(key_name, params[weight_name])
          @head_circumference.write_attribute(key_name, params[head_circumference_name])
          i += 1
        end
        @height.save
      elsif months >= 12
        i = 0
        j = 0
        while i < 6
          key_name = (numbers[i] + '_month').to_sym
          height_name = ('height_' + numbers[i] + '_month').to_sym
          weight_name = (numbers[i] + '_month').to_sym
          head_circumference_name = ('hc_' + numbers[i] + '_month').to_sym
          @height.write_attribute(key_name, params[height_name])
          @weight.write_attribute(key_name, params[weight_name])
          @head_circumference.write_attribute(key_name, params[head_circumference_name])
          i += 1
        end
        if months > 18
          @height.write_attribute(:eighteen_month, params[:height_eighteen_month])
          @weight.write_attribute(:eighteen_month, params[:eighteen_month])
          @head_circumference.write_attribute(:eighteen_month, params[:hc_eighteen_month])
        end
        while j < years
          string_year = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen', 'twenty', 'twentyone', 'twentytwo', 'twentythree', 'twentyfour', 'twentyfive', 'twentysix', 'twentyseven', 'twentyeight', 'twentynine', 'thirty', 'thirtyone', 'thirtytwo', 'thirtythree', 'thirtyfour', 'thirtyfive', 'thirtysix', 'thirtyseven', 'thirtyeight', 'thirtynine', 'forty']
          key_name = (string_year[j] + '_year').to_sym
          height_name = ('height_' + string_year[j] + '_year').to_sym
          weight_name = (string_year[j] + '_year').to_sym
          head_circumference_name = ('hc_' + string_year[j] + '_year').to_sym
          @height.write_attribute(key_name, params[height_name])
          @weight.write_attribute(key_name, params[weight_name])
          @head_circumference.write_attribute(key_name, params[head_circumference_name])
          j += 1
        end
        
      end
    end
    
    if
      @mother_complications.update(
        gestational_diabetes: params[:gestational_diabetes],
        preeclampsia: params[:preeclampsia],
        clampsia: params[:clampsia],
        rh_factor: params[:rh_factor],
        separated_placenta: params[:separated_placenta],
        unsure: params[:unsure],
        extra_fluid: params[:extra_fluid],
        other: params[:other_complications]
      ) &&
      @weight.save &&
      @height.save &&
      @head_circumference.save &&
      @background_history.update(
        weight_at_birth: params[:weight_at_birth][0],
        height_at_birth: params[:height_at_birth][0],
        head_circumference_at_birth: params[:head_circumference_at_birth][0],
        delivery_method: params[:delivery_method],
        offered_c_section: params[:offered_c_section],
        child_complication: params[:child_complication],
        apgar_score: params[:apgar_score],
        gestation_age: params[:gestation_age][0],
        mother_age_at_birth: params[:mother_age_at_birth][0],
        father_age_at_birth: params[:father_age_at_birth][0],
        multiple_birth: params[:multiple_birth],
        multiple_birth_trisomy: params[:multiple_birth_trisomy],
        siblings_with_trisomy: params[:siblings_with_trisomy],
        trisomy_relative: params[:trisomy_relative],
        mother_complication_id: @mother_complications.id,
        head_circumference_id: @head_circumference.id,
        weight_id: @weight.id,
        height_id: @height.id
      ) &&
      @child.update(
        background_history_id: @background_history.id
      )
      flash[:success] = "Background History Successfully Updated!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Background History Could Not Be Updated!"
      render :edit_background_history
    end
  end

  def add_health_history
    @child = Child.find_by(id: params[:id])
    @congenital_heart_defect = CongenitalHeartDefect.new
    @intestinal_issue = IntestinalIssue.new
    @gastric_surgery = GastricSurgery.new
    @nuerological_condition = NuerologicalCondition.new
    @muscular_skeletal = MuscularSkeletal.new
    @cranial_facial = CranialFacial.new
    @endocrine = Endocrine.new
    @hearing = Hearing.new
    @vision = Vision.new
    @behavioral_health = BehavioralHealth.new
    @received_therapy = ReceivedTherapy.new
    @health_history = HealthHistory.new
    render 'add_health_history.html.erb'
  end

  def health_history
    @child = Child.find_by(id: params[:id])
    @congenital_heart_defect = CongenitalHeartDefect.new(
      asd: params[:asd],
      vsd: params[:vsd],
      pda: params[:pda],
      av_canal_defect: params[:av_canal_defect],
      dorv: params[:dorv],
      tof: params[:tof],
      pfo: params[:pfo],
      not_applicable: params[:not_applicable],
      other: params[:other]
    )
    @congenital_heart_defect.save
    @intestinal_issue = IntestinalIssue.new(
      duodenal_atresia_stenosis_web: params[:duodenal_atresia_stenosis_web],
      anal_stenosis_atresia: params[:anal_stenosis_atresia],
      esophageal_atresia: params[:esophageal_atresia],
      hirschsprung_disease: params[:hirschsprung_disease],
      chronic_constipation: params[:chronic_constipation],
      dysphagia: params[:dysphagia],
      aspiration: params[:aspiration],
      chronic_diarrhea: params[:chronic_diarrhea],
      pyloric_stenosis: params[:pyloric_stenosis],
      gastroesophageal_reflux: params[:gastroesophageal_reflux],
      pepticulcers_gallstones: params[:pepticulcers_gallstones],
      hemorrhoids: params[:hemorrhoids],
      diverticulitis_diverticulosis: params[:diverticulitis_diverticulosis],
      colorectal_carcinoma: params[:colorectal_carcinoma],
      ibs: params[:ibs],
      ibd: params[:ibd]
    )
    @intestinal_issue.save
    @gastric_surgery = GastricSurgery.new(
      repair_of_duodenal_atresia_stenosis_web: params[:repair_of_duodenal_atresia_stenosis_web],
      repair_of_anal_stenosis_atresia: params[:repair_of_anal_stenosis_atresia],
      gastrostomy_tube_placement: params[:gastrostomy_tube_placement],
      surgery_for_hirschsprung_disease: params[:surgery_for_hirschsprung_disease],
      fundoplication_nissen_wrap: params[:fundoplication_nissen_wrap],
      none: params[:none],
      other: params[:other_gastric_surgery]
    )
    @gastric_surgery.save
    @nuerological_condition = NuerologicalCondition.new(
      brain_malformation: params[:brain_malformation],
      cyst: params[:cyst],
      cp: params[:cp],
      stroke: params[:stroke],
      unsure: params[:unsure],
      brain_malformation_surgery: params[:brain_malformation_surgery],
      cyst_surgery: params[:cyst_surgery],
      cp_surgery: params[:cp_surgery],
      stroke_surgery: params[:stroke_surgery],
      other: params[:other_nuero_surgery]
    )
    @nuerological_condition.save
    @muscular_skeletal = MuscularSkeletal.new(
      atlanto_axial_instability: params[:atlanto_axial_instability],
      cervical_spine_degeneration: params[:cervical_spine_degeneration],
      osteopenia: params[:osteopenia],
      osteoporosis: params[:osteoporosis],
      fractures: params[:fractures],
      scoliosis: params[:scoliosis],
      lordosis: params[:lordosis],
      kyphosis: params[:kyphosis],
      hand_bone_missing: params[:hand_bone_missing],
      leg_bone_missing: params[:leg_bone_missing],
      rib_deformities: params[:rib_deformities],
      club_foot: params[:club_foot],
      rocker_bottom_feet: params[:rocker_bottom_feet],
      atlanto_axial_instability_surgery: params[:atlanto_axial_instability_surgery],
      cervical_spine_degeneration_surgery: params[:cervical_spine_degeneration_surgery],
      osteopenia_surgery: params[:osteopenia_surgery],
      osteoporosis_surgery: params[:osteoporosis_surgery],
      fractures_surgery: params[:fractures_surgery],
      scoliosis_surgery: params[:scoliosis_surgery],
      lordosis_surgery: params[:lordosis_surgery],
      kyphosis_surgery: params[:kyphosis_surgery],
      hand_bone_missing_surgery: params[:hand_bone_missing_surgery],
      leg_bone_missing_surgery: params[:leg_bone_missing_surgery],
      rib_deformities_surgery: params[:rib_deformities_surgery],
      club_foot_surgery: params[:club_foot_surgery],
      rocker_bottom_feet_surgery: params[:rocker_bottom_feet_surgery]
    )
    @muscular_skeletal.save
    @cranial_facial = CranialFacial.new(
      cranial_deformities: params[:cranial_deformities],
      cleft_palate: params[:cleft_palate],
      cleft_lip: params[:cleft_lip],
      high_arch: params[:high_arch],
      low_set_ears: params[:low_set_ears],
      wide_spaced_eyes: params[:wide_spaced_eyes],
      wild_eyebrows: params[:wild_eyebrows],
      extraordinarily_long_eyelashes: params[:extraordinarily_long_eyelashes],
      overgrowth_of_gums: params[:overgrowth_of_gums],
      delayed_teething: params[:delayed_teething]
    )
    @cranial_facial.save
    @endocrine = Endocrine.new(
      hyperthyroidism: params[:hyperthyroidism],
      hypothyroidism: params[:hypothyroidism],
      early_onset_pubic_hair: params[:early_onset_pubic_hair],
      early_onset_puberty: params[:early_onset_puberty],
      growth_hormone_deficiency: params[:growth_hormone_deficiency],
      calcium_deficiency: params[:calcium_deficiency],
      high_cortisol: params[:high_cortisol],
      diabetes: params[:diabetes],
      hypoglycemia: params[:hypoglycemia],
      cushings_disease: params[:cushings_disease],
      vitamin_d_deficiency: params[:vitamin_d_deficiency],
      anemia: params[:anemia],
      failure_to_thrive: params[:failure_to_thrive],
      high_blood_pressure: params[:high_blood_pressure],
      low_blood_pressure: params[:low_blood_pressure],
      delayed_late_puberty: params[:delayed_late_puberty],
      unsure: params[:unsure],
      other: params[:other_endocrine],
      high_blood_sugar: params[:high_blood_sugar],
      unhealthy_cholesterol_levels: params[:unhealthy_cholesterol_levels],
      increased_abdominal_fat: params[:increased_abdominal_fat]
    )
    @endocrine.save
    @hearing = Hearing.new(
      transient: params[:transient],
      conductive: params[:conductive],
      nerve_loss: params[:nerve_loss],
      unknown: params[:unknown],
      other: params[:other_hearing]
    )
    @hearing.save
    @vision = Vision.new(
      cataract: params[:cataract],
      strabismus: params[:strabismus],
      lazy_eye: params[:lazy_eye],
      near_sighted: params[:near_sighted],
      far_sighted: params[:far_sighted],
      cvi: params[:cvi],
      astigmatism: params[:astigmatism],
      ptosis: params[:ptosis],
      blockage_of_tear_duct: params[:blockage_of_tear_duct],
      depth_perception_problems: params[:depth_perception_problems],
      blindness: params[:blindness],
      glaucoma: params[:glaucoma],
      torn_retina: params[:torn_retina],
      detached_retina: params[:detached_retina],
      undeveloped_eyes: params[:undeveloped_eyes],
      underdeveloped_eyes: params[:underdeveloped_eyes],
      undeveloped_eye_socket: params[:undeveloped_eye_socket],
      underdeveloped_eye_socket: params[:underdeveloped_eye_socket],
      dry_eyes: params[:dry_eyes],
      doesnt_blink_well: params[:doesnt_blink_well],
      doesnt_close_eyes_when_sleeping: params[:doesnt_close_eyes_when_sleeping]
    )
    @vision.save
    @behavioral_health = BehavioralHealth.new(
      add: params[:add],
      adhd: params[:adhd],
      bipolar: params[:bipolar],
      autism_spectrum: params[:autism_spectrum],
      depression: params[:depression],
      anxiety_disorder: params[:anxiety_disorder],
      ocd: params[:ocd],
      schizophrenia: params[:schizophrenia],
      addictions: params[:addictions],
      personality_disorder: params[:personality_disorder],
      eating_disorder: params[:eating_disorder],
      odd: params[:odd],
      other_delay: params[:other_delay],
      other_diagnosis: params[:other_diagnosis],
      conduct_disorder: params[:conduct_disorder],
      none: params[:none],
      learning_disability: params[:learning_disability],
      global_developmental_delay: params[:global_developmental_delay],
      intellectual_disability: params[:intellectual_disability],
      speech_delay: params[:speech_delay],
      receptive_delay: params[:receptive_delay],
      expressive_delay: params[:expressive_delay],
      auditory_processing_disorder: params[:auditory_processing_disorder],
      apraxia_dyspraxia: params[:apraxia_dyspraxia],
      visual_processing: params[:visual_processing]
    )
    @behavioral_health.save
    @received_therapy = ReceivedTherapy.new(
      ot: params[:ot],
      pt: params[:pt],
      dt: params[:dt],
      st: params[:st],
      dtv: params[:dtv],
      dth: params[:dth],
      vital_stim: params[:vital_stim],
      aquatic: params[:aquatic],
      reflex_integration: params[:reflex_integration],
      hippotherapy_equine: params[:hippotherapy_equine],
      hyperbaric: params[:hyperbaric],
      other: params[:other_therapy]
    )
    @received_therapy.save
    @child = Child.find_by(id: params[:id])
    @health_history = HealthHistory.new(
      chd: params[:chd],
      chd_id: @congenital_heart_defect.id,
      offered_cardiac_surgery: params[:offered_cardiac_surgery],
      first_cardiac_surgery_age: params[:first_cardiac_surgery_age],
      first_cardiac_surgery_successful: params[:first_cardiac_surgery_successful],
      multiple_cardiac_surgeries: params[:multiple_cardiac_surgeries],
      intestinal_issues_id: @intestinal_issue.id,
      gastric_surgery_id: @gastric_surgery.id,
      seizure_epilepsy: params[:seizure_epilepsy],
      nuerological_condition_id: @nuerological_condition.id,
      muscular_skeletal_id: @muscular_skeletal.id,
      sleep_apnea: params[:sleep_apnea],
      cranial_facial_id: @cranial_facial.id,
      cancer: params[:cancer],
      other_cancer: params[:cancer_other],
      endocrine_id: @endocrine.id,
      hearing_test: params[:hearing_test],
      had_an_abr: params[:had_an_abr],
      hearing_loss_or_deaf: params[:hearing_loss_or_deaf],
      hearing_loss_treatment: params[:hearing_loss_treatment],
      failed_eye_exam: params[:failed_eye_exam],
      hearing_id: @hearing.id,
      vision_id: @vision.id,
      behavioral_health_id: @behavioral_health.id,
      in_ei: params[:in_ei],
      attend_school: params[:attend_school],
      home_schooled_bound: params[:home_schooled_bound],
      highest_education: params[:highest_education],
      received_therapy_id: @received_therapy.id,
      clinical_trial: params[:clinical_trial],
      clinical_trial_participation: params[:clinical_trial_participation]
    )
    @health_history.save
    if @congenital_heart_defect.save &&
       @gastric_surgery.save &&
       @nuerological_condition.save &&
       @muscular_skeletal.save &&
       @cranial_facial.save &&
       @endocrine.save &&
       @hearing.save &&
       @vision.save &&
       @behavioral_health.save &&
       @received_therapy.save &&
       @health_history.save &&
       @child.update(
         health_history_id: @health_history.id
       )
      flash[:success] = "Health History Added!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Health History Could Not Be Added!"
      render 'add_health_history.html.erb'
    end
  end

  def edit_health_history
    @child = Child.find_by(id: params[:id])
    @health_history = HealthHistory.find_by(id: @child.health_history_id)
    @congenital_heart_defect = CongenitalHeartDefect.find_by(id: @health_history.chd_id)
    @intestinal_issue = IntestinalIssue.find_by(id: @health_history.intestinal_issues_id)
    @gastric_surgery = GastricSurgery.find_by(id: @health_history.gastric_surgery_id)
    @nuerological_condition = NuerologicalCondition.find_by(id: @health_history.nuerological_condition_id)
    @muscular_skeletal = MuscularSkeletal.find_by(id: @health_history.muscular_skeletal_id)
    @cranial_facial = CranialFacial.find_by(id: @health_history.cranial_facial_id)
    @endocrine = Endocrine.find_by(id: @health_history.endocrine_id)
    @hearing = Hearing.find_by(id: @health_history.hearing_id)
    @vision = Vision.find_by(id: @health_history.vision_id)
    @behavioral_health = BehavioralHealth.find_by(id: @health_history.behavioral_health_id)
    @received_therapy = ReceivedTherapy.find_by(id: @health_history.received_therapy_id)
    render 'edit_health_history.html.erb'
  end

  def update_health_history
    @child = Child.find_by(id: params[:id])
    @health_history = HealthHistory.find_by(id: @child.health_history_id)
    @congenital_heart_defect = CongenitalHeartDefect.find_by(id: @health_history.chd_id)
    @intestinal_issue = IntestinalIssue.find_by(id: @health_history.intestinal_issues_id)
    @gastric_surgery = GastricSurgery.find_by(id: @health_history.gastric_surgery_id)
    @nuerological_condition = NuerologicalCondition.find_by(id: @health_history.nuerological_condition_id)
    @muscular_skeletal = MuscularSkeletal.find_by(id: @health_history.muscular_skeletal_id)
    @cranial_facial = CranialFacial.find_by(id: @health_history.cranial_facial_id)
    @endocrine = Endocrine.find_by(id: @health_history.endocrine_id)
    @hearing = Hearing.find_by(id: @health_history.hearing_id)
    @vision = Vision.find_by(id: @health_history.vision_id)
    @behavioral_health = BehavioralHealth.find_by(id: @health_history.behavioral_health_id)
    @received_therapy = ReceivedTherapy.find_by(id: @health_history.received_therapy_id)
    if
      @congenital_heart_defect.update(
        asd: params[:asd],
        vsd: params[:vsd],
        pda: params[:pda],
        av_canal_defect: params[:av_canal_defect],
        dorv: params[:dorv],
        tof: params[:tof],
        pfo: params[:pfo],
        not_applicable: params[:not_applicable],
        other: params[:other]
      ) &&
      @intestinal_issue.update(
        duodenal_atresia_stenosis_web: params[:duodenal_atresia_stenosis_web],
        anal_stenosis_atresia: params[:anal_stenosis_atresia],
        esophageal_atresia: params[:esophageal_atresia],
        hirschsprung_disease: params[:hirschsprung_disease],
        chronic_constipation: params[:chronic_constipation],
        dysphagia: params[:dysphagia],
        aspiration: params[:aspiration],
        chronic_diarrhea: params[:chronic_diarrhea],
        pyloric_stenosis: params[:pyloric_stenosis],
        gastroesophageal_reflux: params[:gastroesophageal_reflux],
        pepticulcers_gallstones: params[:pepticulcers_gallstones],
        hemorrhoids: params[:hemorrhoids],
        diverticulitis_diverticulosis: params[:diverticulitis_diverticulosis],
        colorectal_carcinoma: params[:colorectal_carcinoma],
        ibs: params[:ibs],
        ibd: params[:ibd]
      ) &&
      @gastric_surgery.update(
        repair_of_duodenal_atresia_stenosis_web: params[:repair_of_duodenal_atresia_stenosis_web],
        repair_of_anal_stenosis_atresia: params[:repair_of_anal_stenosis_atresia],
        gastrostomy_tube_placement: params[:gastrostomy_tube_placement],
        surgery_for_hirschsprung_disease: params[:surgery_for_hirschsprung_disease],
        fundoplication_nissen_wrap: params[:fundoplication_nissen_wrap],
        none: params[:none],
        other: params[:other_gastric_surgery]
      ) &&
      @nuerological_condition.update(
        brain_malformation: params[:brain_malformation],
        cyst: params[:cyst],
        cp: params[:cp],
        stroke: params[:stroke],
        unsure: params[:unsure],
        brain_malformation_surgery: params[:brain_malformation_surgery],
        cyst_surgery: params[:cyst_surgery],
        cp_surgery: params[:cp_surgery],
        stroke_surgery: params[:stroke_surgery],
        other: params[:other_nuero_surgery]
      ) &&
      @muscular_skeletal.update(
        atlanto_axial_instability: params[:atlanto_axial_instability],
        cervical_spine_degeneration: params[:cervical_spine_degeneration],
        osteopenia: params[:osteopenia],
        osteoporosis: params[:osteoporosis],
        fractures: params[:fractures],
        scoliosis: params[:scoliosis],
        lordosis: params[:lordosis],
        kyphosis: params[:kyphosis],
        hand_bone_missing: params[:hand_bone_missing],
        leg_bone_missing: params[:leg_bone_missing],
        rib_deformities: params[:rib_deformities],
        club_foot: params[:club_foot],
        rocker_bottom_feet: params[:rocker_bottom_feet],
        atlanto_axial_instability_surgery: params[:atlanto_axial_instability_surgery],
        cervical_spine_degeneration_surgery: params[:cervical_spine_degeneration_surgery],
        osteopenia_surgery: params[:osteopenia_surgery],
        osteoporosis_surgery: params[:osteoporosis_surgery],
        fractures_surgery: params[:fractures_surgery],
        scoliosis_surgery: params[:scoliosis_surgery],
        lordosis_surgery: params[:lordosis_surgery],
        kyphosis_surgery: params[:kyphosis_surgery],
        hand_bone_missing_surgery: params[:hand_bone_missing_surgery],
        leg_bone_missing_surgery: params[:leg_bone_missing_surgery],
        rib_deformities_surgery: params[:rib_deformities_surgery],
        club_foot_surgery: params[:club_foot_surgery],
        rocker_bottom_feet_surgery: params[:rocker_bottom_feet_surgery]
      ) &&
      @cranial_facial.update(
        cranial_deformities: params[:cranial_deformities],
        cleft_palate: params[:cleft_palate],
        cleft_lip: params[:cleft_lip],
        high_arch: params[:high_arch],
        low_set_ears: params[:low_set_ears],
        wide_spaced_eyes: params[:wide_spaced_eyes],
        wild_eyebrows: params[:wild_eyebrows],
        extraordinarily_long_eyelashes: params[:extraordinarily_long_eyelashes],
        overgrowth_of_gums: params[:overgrowth_of_gums],
        delayed_teething: params[:delayed_teething]
      ) &&
      @endocrine.update(
        hyperthyroidism: params[:hyperthyroidism],
        hypothyroidism: params[:hypothyroidism],
        early_onset_pubic_hair: params[:early_onset_pubic_hair],
        early_onset_puberty: params[:early_onset_puberty],
        growth_hormone_deficiency: params[:growth_hormone_deficiency],
        calcium_deficiency: params[:calcium_deficiency],
        high_cortisol: params[:high_cortisol],
        diabetes: params[:diabetes],
        hypoglycemia: params[:hypoglycemia],
        cushings_disease: params[:cushings_disease],
        vitamin_d_deficiency: params[:vitamin_d_deficiency],
        anemia: params[:anemia],
        failure_to_thrive: params[:failure_to_thrive],
        high_blood_pressure: params[:high_blood_pressure],
        low_blood_pressure: params[:low_blood_pressure],
        delayed_late_puberty: params[:delayed_late_puberty],
        unsure: params[:unsure],
        other: params[:other_endocrine],
        high_blood_sugar: params[:high_blood_sugar],
        unhealthy_cholesterol_levels: params[:unhealthy_cholesterol_levels],
        increased_abdominal_fat: params[:increased_abdominal_fat]
      ) &&
      @hearing.update(
        transient: params[:transient],
        conductive: params[:conductive],
        nerve_loss: params[:nerve_loss],
        unknown: params[:unknown],
        other: params[:other_hearing]
      ) &&
      @vision.update(
        cataract: params[:cataract],
        strabismus: params[:strabismus],
        lazy_eye: params[:lazy_eye],
        near_sighted: params[:near_sighted],
        far_sighted: params[:far_sighted],
        cvi: params[:cvi],
        astigmatism: params[:astigmatism],
        ptosis: params[:ptosis],
        blockage_of_tear_duct: params[:blockage_of_tear_duct],
        depth_perception_problems: params[:depth_perception_problems],
        blindness: params[:blindness],
        glaucoma: params[:glaucoma],
        torn_retina: params[:torn_retina],
        detached_retina: params[:detached_retina],
        undeveloped_eyes: params[:undeveloped_eyes],
        underdeveloped_eyes: params[:underdeveloped_eyes],
        undeveloped_eye_socket: params[:undeveloped_eye_socket],
        underdeveloped_eye_socket: params[:underdeveloped_eye_socket],
        dry_eyes: params[:dry_eyes],
        doesnt_blink_well: params[:doesnt_blink_well],
        doesnt_close_eyes_when_sleeping: params[:doesnt_close_eyes_when_sleeping]
      ) &&
      @behavioral_health.update(
        add: params[:add],
        adhd: params[:adhd],
        bipolar: params[:bipolar],
        autism_spectrum: params[:autism_spectrum],
        depression: params[:depression],
        anxiety_disorder: params[:anxiety_disorder],
        ocd: params[:ocd],
        schizophrenia: params[:schizophrenia],
        addictions: params[:addictions],
        personality_disorder: params[:personality_disorder],
        eating_disorder: params[:eating_disorder],
        odd: params[:odd],
        other_delay: params[:other_delay],
        other_diagnosis: params[:other_diagnosis],
        conduct_disorder: params[:conduct_disorder],
        none: params[:none],
        learning_disability: params[:learning_disability],
        global_developmental_delay: params[:global_developmental_delay],
        intellectual_disability: params[:intellectual_disability],
        speech_delay: params[:speech_delay],
        receptive_delay: params[:receptive_delay],
        expressive_delay: params[:expressive_delay],
        auditory_processing_disorder: params[:auditory_processing_disorder],
        apraxia_dyspraxia: params[:apraxia_dyspraxia],
        visual_processing: params[:visual_processing]
      ) &&
      @received_therapy.update(
        ot: params[:ot],
        pt: params[:pt],
        dt: params[:dt],
        st: params[:st],
        dtv: params[:dtv],
        dth: params[:dth],
        vital_stim: params[:vital_stim],
        aquatic: params[:aquatic],
        reflex_integration: params[:reflex_integration],
        hippotherapy_equine: params[:hippotherapy_equine],
        hyperbaric: params[:hyperbaric],
        other: params[:other_therapy]
      ) &&
      @health_history.update(
        chd: params[:chd],
        chd_id: @congenital_heart_defect.id,
        offered_cardiac_surgery: params[:offered_cardiac_surgery],
        first_cardiac_surgery_age: params[:first_cardiac_surgery_age][0],
        first_cardiac_surgery_successful: params[:first_cardiac_surgery_successful],
        multiple_cardiac_surgeries: params[:multiple_cardiac_surgeries],
        intestinal_issues_id: @intestinal_issue.id,
        gastric_surgery_id: @gastric_surgery.id,
        seizure_epilepsy: params[:seizure_epilepsy],
        nuerological_condition_id: @nuerological_condition.id,
        muscular_skeletal_id: @muscular_skeletal.id,
        sleep_apnea: params[:sleep_apnea],
        cranial_facial_id: @cranial_facial.id,
        cancer: params[:cancer],
        other_cancer: params[:cancer_other],
        endocrine_id: @endocrine.id,
        hearing_test: params[:hearing_test],
        had_an_abr: params[:had_an_abr],
        hearing_loss_or_deaf: params[:hearing_loss_or_deaf],
        hearing_loss_treatment: params[:hearing_loss_treatment],
        failed_eye_exam: params[:failed_eye_exam],
        hearing_id: @hearing.id,
        vision_id: @vision.id,
        behavioral_health_id: @behavioral_health.id,
        in_ei: params[:in_ei],
        attend_school: params[:attend_school],
        home_schooled_bound: params[:home_schooled_bound],
        highest_education: params[:highest_education],
        received_therapy_id: @received_therapy.id,
        clinical_trial: params[:clinical_trial],
        clinical_trial_participation: params[:clinical_trial_participation]
      ) &&
      @child.update(
        health_history_id: @health_history.id
      )
      flash[:success] = "Health History Successfully Updated!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Health History Could Not Be Updated!"
      render 'edit_health_history.html.erb'
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
