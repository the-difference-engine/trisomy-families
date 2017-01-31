class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.find_by(id: params[:id])
    @user.update(
      user_type: params[:user_type]
    )
  end
end