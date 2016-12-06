class Api::V1::SearchController < ApplicationController

  def index
    if params[:type] == "physician"
      rows = Physician.where(hash_params)

    elsif params[:type] == "family"
      rows = User.where(hash_params)

    else
      render nothing: true, status: 404
    end

  end

  private

  def hash_params
    h = {}
    h[:state] = params[:state] if params[:state] != ""
    h[:city] = params[:city] if params[:city] != ""
    h[:last_name] = params[:last_name] if params[:last_name] != ""
    h[:speciality] = params[:speciality] if params[:speciality] != "" && params[type] == "physician"
    return h
  end
  
end
