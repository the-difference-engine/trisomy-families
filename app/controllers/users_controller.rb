class UsersController < ApplicationController

  def index
    @users = User.all
    if current_user && current_user.user_type == 'admin'
      @family = Family.find_by(user_id: current_user.id)
      render 'index.html.erb'
    elsif current_user && current_user.user_type == 'doctor'
      redirect_to "/physicians/#{current_user.id}"
    else
      flash[:warning] = 'You must be an administrator to view this page!'
      redirect_to '/'
    end
  end

  def about
    render 'about.html.erb'
  end

  def home
  end

  def children_index
    @children = Child.all
    if current_user && current_user.user_type == 'admin'
      render 'children_index.html.erb'
    else
      flash[:warning] = 'You must be an administrator to view this page!'
      redirect_to '/'
    end
  end

  def update 
  end

  def calendar
    render 'calendar.html.erb'
  end

  def query_table
    render 'queries.html.erb'
  end

end
