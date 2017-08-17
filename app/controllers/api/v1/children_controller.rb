# API/V1/ChildrenController
class Api::V1::ChildrenController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'sendgrid-ruby'
  include SendGrid

  def index
    if current_user && current_user.user_type == "admin"
      @children = Child.all
      render 'index.json.jbuilder'
    else
      flash[:warning] = "You do not have permission to view that page." 
      redirect_to "/"
    end
  end

  def trisomy_type_totals
    if current_user
      all_children = Child.all
      @trisomy_types = []
      @trisomy_types_hash = Hash.new
      all_children.each do |child|
        @trisomy_types << child.trisomy_type
      end

      @trisomy_types.each do |trisomy_type|
        @trisomy_types_hash[trisomy_type] =+ 1
      end

      @trisomy_types.each_with_object(@trisomy_types_hash) { |word,counts| counts[word] += 1 }

      @trisomy_types_hash.each do |key, value|
        @trisomy_types_hash[key] = value - 1
      end

      render 'index2.json.jbuilder'
    else
      redirect_to "/"
    end
  end

  def birth_order_totals
    if current_user
      all_children = Child.all
      @birth_order_array = []
      @birth_order_hash = Hash.new
      all_children.each do |child|
        @birth_order_array << child.birth_order
      end

      @birth_order_array.each do |birth_order|
        @birth_order_hash[birth_order] =+ 1
      end

      @birth_order_array.each_with_object(@birth_order_hash) { |word,counts| counts[word] += 1 }

      @birth_order_hash.each do |key, value|
        @birth_order_hash[key] = value - 1
      end
      render 'index3.json.jbuilder'
    end
  end

  def update
    if current_user
      my_family = Family.find_by(user_id: current_user.id)
      @child = Child.find_by(id: params[:id])
      if @child && current_user.user_type == "admin"
        if params["accepted"] == "Accept Child"
          @child.update(
            accepted: true
          )
          if @child.save
            user_alert(@child)
            flash[:success] = "The participant's registration has been accepted. The registration's contact will receive a confimation email."
            redirect_to '/children-index'
          end
        elsif params["accepted"] == "Accept & Register Child"
          @child.update(
            registered: true,
            accepted: true
          )
          if @child.save
            flash[:success] = "The participant has been registered and accepted."
            redirect_to '/children-index'
          end
        end
        
      else
        flash[:warning] = "You do not have permission to view that page."
        redirect_to "/"
      end
    end
  end

  def user_alert(child)
    register_contact_info = ContactInfoForm.find_by(child_id: child.id)    

    from = Email.new(email: ENV["SENDGRID_USERNAME"])
    to = Email.new(email: register_contact_info.contact_email)
    subject = 'Child Registration'
    message = "Congratulations, your Trisomy participant #{child.first_name} #{child.last_name}'s registration has been accepted! Thank you for connecting with us."

    content = Content.new(type: 'text/html', value: message)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def destroy
    if current_user
      @child = Child.find_by(id: params[:id])
      if (@child.family_id == my_family.id) || current_user.user_type == "admin"
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
        @child.destroy 
        @privacy.destroy
        @children = Child.all
        render 'index.json.jbuilder'
      else
        flash[:warning] = "You do not have permission to view that page."
        redirect_to "/"
      end
    else
      flash[:warning] = "You do not have permission to view that page."
      redirect_to "/"
    end
  end
end
