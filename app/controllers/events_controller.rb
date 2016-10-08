class EventsController < ApplicationController

# Needs to be here for current_user to work
# Might not be the most secure option
skip_before_action :verify_authenticity_token

  def create
    @user = User.find_by(id: 1)

    @event = Event.new(event_params)
    @event.date = parse_date
    @event.save

    redirect_to '/'
  end

  private

    def event_params
      params.permit(:title, :description, :date)
    end

    def parse_date
      return Date.parse(params[:date_time])
    end

end
