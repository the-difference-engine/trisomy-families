class FamilyCenterController < ApplicationController
  def index
    if !current_user
      flash[:warning] = 'You must be logged in to view this page.'

      redirect_to '/users/sign_in'
    end
  end
end
