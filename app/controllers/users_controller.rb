class UsersController < ApplicationController
  def index
    if current_user
      if current_user.children.empty?
        redirect_to '/profile/new' 
      else
        render 'index.html.erb'
      end
    end
  end

  def new_profile
  end

  def create_profile
  end

  def calendar
    render 'calendar.html.erb'
  end

  def query_table
    render 'queries.html.erb'
  end
end
