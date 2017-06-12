class RegistrationsController < ApplicationController
  def index
  end

  def show
    @child = Child.find_by(id: params[:id])
    if @child
      @family = Family.find_by(id: @child.family_id)
      @contact_info = ContactInfoForm.find_by(child_id: @child.id)
      @background_history = BackgroundHistory.find_by(id: @child.background_history_id)
      @health_history = HealthHistory.find_by(id: @child.health_history_id)
      render 'show.html.erb'
    else
      flash[:danger] = "That registration does not exist! Do have a child/participant profile?"
      redirect_to '/'
    end
  end

  def destroy
  end
end
