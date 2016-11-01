class EventsController < ApplicationController

# Needs to be here for current_user to work
# Might not be the most secure option
skip_before_action :verify_authenticity_token

before_action :authenticate_user!

  def index
    #order the events by date
    @events = Event.order(:start).all
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = 'New Event Created.'
      redirect_to '/'
    else
      flash[:alert] = @event.errors.full_messages
      render 'new'
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start, :end)
    end

end
