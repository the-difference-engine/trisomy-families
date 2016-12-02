class Api::V1::FamilyCenterController < ApplicationController

  # state = ""
  # last_name = ""
  # category = ""

  def index
    if params[:category] == "family"
      if params[:last_name] != ""
        @families = User.where("state = ?", params[:state]).all
      else
        @families = User.where("state = ?", params[:state]).all
      end
    elsif params[:category] == "physician"
      @physicians = Physician.where("state = ?", params[:state]).all
    else

    end
  end


end
