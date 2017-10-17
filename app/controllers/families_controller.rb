class FamiliesController < ApplicationController
  def index
    # Get stories (when model is created)

    # Get parents (when model is ready)

    # Get children
    if current_user
      @children = Child.where(user_id: current_user.id)
      if @children.count == 0
        redirect_to '/profile/new'

      else
        @children.each do |child|
          @parents = Parent.where(id: child.parent_id)
         end
         render 'index.html.erb'
      end

    else
      flash[:warning] = 'You must be logged in to view this page.'

      redirect_to '/users/sign_in'

    end
  end

  def new
    @family = Family.find_by(user_id: current_user.id)
    if @family && current_user.user_type == "family"      
      redirect_to "/families/#{@family.id}"
    else
      @family = Family.new
      render 'new.html.erb'
    end
  end

  def create

    @family = Family.new(
      family_name: params["family"]["family_name"],
      street_address: params["family"]["street_address"],
      city: params["family"]["city"],
      state: params["family"]["state"],
      story: params["family"]["story"],
      website: params["family"]["website"],
      user_id: current_user.id
      )   

      if params["family"]["photo"]
        charset = Array('A'..'Z') + Array('a'..'z')
        random_string = Array.new(20) { charset.sample }.join
        object_name = random_string + '_' + params["family"]["photo"].original_filename
        obj = S3_BUCKET.object(object_name)
        obj.upload_file(params["family"]["photo"].tempfile.path)
        puts "********"
        puts @family
        @family.update(photo: obj.public_url)
      end

      if @family.save

        flash[:success] = "Family Successfully Added!"
        redirect_to "/families/#{@family.id}"

      else
        render '/families/new'
      end
  end

  def show
    @family = Family.find_by(id: params[:id])
    if @family != nil
      @admin = User.where(user_type: "admin").first
      @children = []
      Child.all.each do |child|
        if child.family_id == @family.id
          @children << child
        end
      end
      if current_user && current_user.user_type != "doctor"
        user_family = Family.find_by(user_id: current_user.id)
        if user_family != nil
          render 'show.html.erb'
        else 
          redirect_to "/families/new"
        end
      elsif current_user && current_user.user_type == "doctor"
        doctor = Physician.find_by(user_id: current_user.id)
        if doctor
          redirect_to "/physicians/#{doctor.id}"
        else
          redirect_to "/physicians/new"
        end
      else
        flash[:warning] = 'You must be logged in to view this page.'
        redirect_to '/' 
      end
    else
      redirect_to '/'
    end
  end

  def edit
    @family = Family.find_by(id: params[:id])

    if @family.user_id != current_user.id && current_user.user_type != "admin"
     @family = Family.find_by(user_id: current_user.id)
     flash[:danger] = "You do not have permission to view that page."
     redirect_to "/families/#{@family.id}"
    end 
  
  end

  def update
    @family = Family.find_by(id: params[:id])

    @family.family_name = params[:family][:family_name]
    @family.story = params[:family][:story]
    @family.city = params[:family][:city]
    @family.state = params[:family][:state]
    @family.street_address = params[:family][:street_address]
    @family.website = params[:family][:website]
    @family.save
    if params["family"]["photo"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["family"]["photo"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["family"]["photo"].tempfile.path)
      puts "********"
      puts @family
      @family.update(photo: obj.public_url)
    end
    if @family.save
      flash[:success] = "Family Successfully Updated!"
      redirect_to "/families/#{@family.id}"
    else
      render '/families/edit'
    end 
  end
end
