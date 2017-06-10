class RegistrationsController < ApplicationController
  def index
  end

  def show
    @child = Child.find(params[:id])
    @contact_info = ContactInfoForm.find_by(child_id: @child.id)
    @background_histroy = BackgroundHistory.find(@child.background_histroy_id)
    @health_history = HealhHistory.find(@child.health_history_id)
  end

  def destroy
  end
end
