class Api::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @users = User.all
  end

  def update
    @users = User.all
    @user = User.find_by(id: params[:id])
    @user.update(
      user_type: params[:user_type]
    )
    @user.save(validate: false)
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy

  end



end