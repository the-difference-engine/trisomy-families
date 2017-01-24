class AdminsController < ApplicationController
  def index
    if current_user.user_type == 'admin'
      render 'index.html.erb'
    else
      flash[:warning] = 'You must be an administrator to view this page.'
      redirect_to '/'
    end
  end
end
