class BackgroundHistoryFormsController < ApplicationController
  def new
    @child = Child.find_by(id: params[:child_id])
    if @child
      @child_id = params[:child_id]     
      @mother_complications = MotherComplication.new
      @weight = Weight.new
      @height = Height.new
      @head_circumference = HeadCircumference.new
      @background_history = BackgroundHistory.new
      render 'new.html.erb'
    else
      flash[:danger] = "Something went wrong: Child id missing in params or does not belong to existing child."
      redirect_to '/'
    end
  end

  def create
    @child = Child.find_by(id: params[:child_id])
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
        @weight.save
        @head_circumference.save
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
      child_complication: params[:child_complication],
      apgar_score: params[:apgar_score],
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
<<<<<<< HEAD
      redirect_to "/children/#{@child.id}"
=======
      redirect_to "/profile/#{@child.id}"
>>>>>>> 62f0045fe3cb99259a672040322271b6855d6d94
    else
      flash[:warning] = "Unable to add Background History!"
      render 'new.html.erb'
    end

  end

  def show
  end

  def edit
    @background_history = BackgroundHistory.find_by(id: params[:id])
    @child = Child.find_by(background_history_id: @background_history.id)
    @mother_complications = MotherComplication.find_by(id: @background_history.mother_complication_id)
    @weight = Weight.find_by(id: @background_history.weight_id)
    @height = Height.find_by(id: @background_history.height_id)
    @head_circumference = HeadCircumference.find_by(id: @background_history.head_circumference_id)
  end

  def update
    @background_history = BackgroundHistory.find_by(id: params[:id])
    @child = Child.find_by(background_history_id: @background_history.id)
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
        weight_at_birth: params[:weight_at_birth],
        height_at_birth: params[:height_at_birth],
        head_circumference_at_birth: params[:head_circumference_at_birth],
        delivery_method: params[:delivery_method],
        offered_c_section: params[:offered_c_section],
        child_complication: params[:child_complication],
        apgar_score: params[:apgar_score],
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
      ) &&
      @child.update(
        background_history_id: @background_history.id
      )
      flash[:success] = "Background History Successfully Updated!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Background History Could Not Be Updated!"
      render 'edit.html.erb'
    end
  end

end
