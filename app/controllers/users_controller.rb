class UsersController < ApplicationController
layout :logged_in?
  def index
    @users = User.all
    if current_user && current_user.user_type == 'admin'
      render 'index.html.erb'
    else
      flash[:warning] = 'You must be an administrator to view this page!'
      redirect_to '/'
    end
  end

  def home
    if current_user
      if current_user.children.empty? && current_user.user_type.nil?
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

  def update
  end

  def calendar
    render 'calendar.html.erb'
  end

  def query_table
    render 'queries.html.erb'
  end

  private
  def logged_in?
    if user_signed_in?
      "application"
    else
      "homepage"
    end
  end
end
