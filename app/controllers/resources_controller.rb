class ResourcesController < ApplicationController

  def index
    @resources = Resource.all
  end

  def valid_url?(url)
    url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    url =~ url_regexp ? true : false
  end

  def create 
    @resource = Resource.new(
      name: params["resource"]["name"],
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
      flash[:success] = "Resource #{@resource.name} Created!"
      redirect_to "/resources"
    else
      render 'new.html.erb'
    end
  end

  def new
    if current_user
      @resource = Resource.new
    else
      flash[:warning] = 'You must be an administrator to view this page!'
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

end
