class UsersController < ApplicationController
  def index
    if current_user.user_type == 'admin'
      render 'index.html.erb'
    else
      flash[:warning] = 'You must be an administrator to view this page!'
      redirect_to '/'
    end
  end

  def home
    if current_user
      if current_user.children.empty?
        redirect_to '/profile/new'
      elsif current_user.user_type == 'admin'
        redirect_to '/admin-dashboard'
      else
        render 'home.html.erb'
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
