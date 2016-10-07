class EventsController < ApplicationController

# Needs to be here for current_user to work
# Might not be the most secure option
skip_before_filter :verify_authenticity_token

  def create
    @user = User.find_by(id: current_user.id)

    @event = Event.new(title: params[:title],
                       description: params[:description],
                       date: Date.parse(params[:date_time]))
    @event.save

    redirect_to '/'
  end

end
