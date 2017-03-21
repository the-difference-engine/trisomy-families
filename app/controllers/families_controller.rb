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
    @family = Family.new
    render 'new.html.erb'
  end

  def create
    @family = Family.new(
      family_name: params["family"]["family_name"],
      street_address: params["family"]["street_address"],
      city: params["family"]["city"],
      state: params["family"]["state"],
      story: params["family"]["story"],
      user_id: current_user.id
    )

      @family.save
      current_user.update(family_id: @family.id)
      flash[:success] = "Family Successfully Added!"
      redirect_to "/families/#{@family.id}"
  end

  def show
    @family = Family.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def edit
    @family = Family.find_by(id: params[:id])
  end

  def update
    @family = Family.find_by(id: params[:id])

    @family.family_name = params[:family_name]
    @family.story = params[:story]
    @family.city = params[:city]
    @family.state = params[:state]

    @family.save

    redirect_to "/families/#{@family.id}"
  end
end
