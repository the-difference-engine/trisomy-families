class RegistrationsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid

  def index
  end

  def update
    @child = Child.find_by(id: params[:id])
    if params["submition"] == "Submit Registration"
      @child.update(
        registered: true
      )
      if @child.save
        admin_alert(@child)
        flash[:success] = "Registration for #{@child.first_name} #{@child.last_name} has been submitted successfully."
        redirect_to '/registration/#{child.id}'
      end
    end
  end

  def show
    @child = Child.find_by(id: params[:id])

    if @child
      @family = Family.find_by(id: @child.family_id)
      @contact_info = ContactInfoForm.find_by(child_id: @child.id)
      @background_history = BackgroundHistory.find_by(id: @child.background_history_id)
      @health_history = HealthHistory.find_by(id: @child.health_history_id)
      if @background_history != nil 
        @mother_complications = presence_of_one(@background_history.mother_complication.attributes)
      end

      render 'show.html.erb'
    else
      flash[:danger] = "That registration does not exist! Do you have a child/participant profile?"
      redirect_to '/'
    end
  end

  def destroy
  end

  def presence_of_one(entity_attrs)
    entity_attrs.each do |attr_name, attr_value|
      if attr_name != 'id' && attr_name != 'created_at' && attr_name != 'updated_at'
        if attr_value != nil
          return true
        else
          return false
        end
      end
    end
  end

  def admin_alert(child)
    # Will only notify oldest admin (first created)
    admin_email = User.where(user_type: "admin").first.email

    from = Email.new(email: ENV["SENDGRID_USERNAME"])
    to = Email.new(email: admin_email)
    subject = 'Child Registration Submition'
    message = "#{current_user.first_name} #{current_user.last_name} (#{current_user.email}) has submitted registration for #{child.first_name} #{child.last_name}. Please review it accordingly."

    content = Content.new(type: 'text/html', value: message)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

end
