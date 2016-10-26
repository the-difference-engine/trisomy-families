class Api::V1::EventsController < ApplicationController

  def index
    @events = Event.all
    render 'index.json.jbuilder'
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = 'New Event Created.'
    else
      flash[:alert] = @event.errors.full_messages
      render 'index'
    end
  end

  private

    def event_params
      params.permit(:title, :description, :location, :allDay, :event_type, :end, :start)
    end

end
