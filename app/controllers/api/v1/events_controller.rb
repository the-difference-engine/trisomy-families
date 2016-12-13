class Api::V1::EventsController < ApplicationController

  def index
    @events = Event.order(:start).all
    render 'index.json.jbuilder'
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = 'New Event Created.'
      redirect_to '/calendar'
    else
      flash[:alert] = @event.errors.full_messages
      render 'index'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @event = Event.find_by(id: params[:id])

    if @event.update(event_params)
      flash[:notice] = 'Event changed'
      render json: {
        status: 200
      }
    else
      render json: {
        error: @event.errors.full_messages,
        status: 400
      }
    end

  end

  private

    def event_params
      params.permit(:title, :description, :location, :allDay, :event_type, :end, :start)
    end

end
