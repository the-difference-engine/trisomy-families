class EventsController < ApplicationController
# before_action :authenticate_user!

  def create
    @user = User.find_by(id: 1)
    @event = Event.new(title: params[:title],
                       description: params[:description],
                       date: Date.parse(params[:date_time]))
    @event.save
    redirect_to '/'
  end

end
