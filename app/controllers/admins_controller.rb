class AdminsController < ApplicationController
  def index
    if current_user.user_type == 'admin'
      render 'index.html.erb'
    else
      redirect_to '/'
    end
  end
end
