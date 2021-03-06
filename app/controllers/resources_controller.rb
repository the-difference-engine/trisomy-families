class ResourcesController < ApplicationController
  include StatesHelper
  require 'sendgrid-ruby'
  include SendGrid

  def index
    @resources = Resource.all
    search_term = params[:search_term]
    sort_attribute = params[:sort]
    sort_order = params[:sort_order]

    if search_term
      us_states.each do |state|
        if search_term.downcase == state[0].downcase
          search_term = state[1]
        end
      end
      @resources = @resources.where("name iLIKE ? OR description iLIKE ? OR state iLIKE ? OR purpose iLIKE ?", 
                                "%#{search_term}%",
                                "%#{search_term}%",
                                "%#{search_term}%",
                                "%#{search_term}%")
    end

    if sort_attribute && sort_order
      @resources = @resources.order(sort_attribute => sort_order)
    end

    if current_user
      if current_user.user_type == "family"

        my_family = Family.find_by(user_id: current_user.id)
        registered = false      
        if my_family != nil
          my_family.children.each do |child|
            if child.accepted
              registered = true
            end
          end
        end

        if registered == true
          @permissions = true
        else
          @permissions = false
        end

      else
        @permissions = true
      end
    else
      @permissions = false
    end

  end  

  def create 
    @resource = Resource.new(
      name: params["resource"]["name"],
      state: params["resource"]["state"],
      purpose: params["resource"]["purpose"],
      description: params["resource"]["description"]
    )
    if params["resource"]["url"] != ""
      if valid_url?(params["resource"]["url"]) ||  params["resource"]["url"].split('.')[0].include?('http')
        @resource.assign_attributes(url: params["resource"]["url"]) 
      else
        fixed_url = 'http://' + params["resource"]["url"]
        @resource.assign_attributes(url: fixed_url) 
      end
    end
    if params["resource"]["image"] == "" 
      @resource.assign_attributes(image: 'http://westerndental.ie/wp-content/plugins/social-media-builder//img/no-image.png') 
    elsif valid_url?(params["resource"]["image"]) ||  params["resource"]["image"].split('.')[0].include?('www')
      @resource.assign_attributes(image: params["resource"]["image"]) 
    else
      fixed_url = 'http://' + params["resource"]["image"]
      @resource.assign_attributes(image: fixed_url) 
    end

    if @resource.save
      # Send email alert to admin
      admin_alert

      flash[:success] = "Resource #{@resource.name} Created!"
      redirect_to "/resources"
    else
      render 'new.html.erb'
    end
  end

  def new
    if current_user

      if current_user.user_type == "family"

        my_family = Family.find_by(user_id: current_user.id)
        registered = false      
        my_family.children.each do |child|
          if child.accepted
            registered = true
          end
        end

        if registered
          @resource = Resource.new
          render 'new.html.erb'
        else
          flash[:danger] = 'You must have at least one registered participant to access that page.'
          redirect_to '/'
        end

      else
        @resource = Resource.new
        render 'new.html.erb'
      end
     
    else
      flash[:danger] = 'You do not have access to that page.'
      redirect_to '/'
    end
  end

  def edit
    if current_user && current_user.user_type == 'admin'
      @resource = Resource.find_by(id: params[:id])
    else
      flash[:warning] = 'You must be an administrator to view this page!'
      redirect_to '/'
    end
  end

  def update
    @resource = Resource.find_by(id: params[:id])
    @resource.assign_attributes(
      name: params["resource"]["name"],
      state: params["resource"]["state"],
      purpose: params["resource"]["purpose"],
      description: params["resource"]["description"]
    )

    if valid_url?(params["resource"]["url"]) ||  params["resource"]["url"].split('.')[0].include?('http')
      @resource.assign_attributes(url: params["resource"]["url"]) 
    else
      fixed_url = 'http://' + params["resource"]["url"]
      @resource.assign_attributes(url: fixed_url) 
    end

    if params["resource"]["image"] == "" 
      @resource.assign_attributes(image: 'http://westerndental.ie/wp-content/plugins/social-media-builder//img/no-image.png') 
    elsif valid_url?(params["resource"]["image"]) ||  params["resource"]["image"].split('.')[0].include?('www')
      @resource.assign_attributes(image: params["resource"]["image"]) 
    else
      fixed_url = 'http://' + params["resource"]["image"]
      @resource.assign_attributes(image: fixed_url) 
    end

    if @resource.save
      flash[:success] = "Resource #{@resource.name} Updated Successfully!"
      redirect_to '/resources'
    else
      render :edit
    end

  end

  def destroy
    @resource = Resource.find_by(id: params[:id])
    if @resource.destroy
      flash[:warning] = "Resource #{@resource.name} Deleted Successfully!"
      redirect_to '/resources'
    end
  end

  def valid_url?(url)
    url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    url =~ url_regexp ? true : false
  end

  def admin_alert
    # Will only notify oldest admin (first created)
    admin_email = User.where(user_type: "admin").first.email

    from = Email.new(email: ENV["SENDGRID_USERNAME"])
    to = Email.new(email: admin_email)
    subject = 'A new resource has been added'
    message = "#{current_user.first_name} #{current_user.last_name} (#{current_user.email}) has added a new resource to the Trisomy Association website. Link to resources: #{request.url}"

    content = Content.new(type: 'text/html', value: message)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

end
