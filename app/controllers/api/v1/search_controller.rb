class Api::V1::SearchController < ApplicationController

  def index
    if params[:type] == "physician"
      rows = Physician.where(hash_params)
      if params[:limit] != nil
        rows = rows.limit(params[:limit].to_i)
      end

      render json: rows, each_serializer: Api::V1::PhysicianSerializer, adapter: :json_api, root: false

    elsif params[:type] == "family"
      rows = User.where(hash_params)
      if params[:limit] != nil
        rows = rows.limit(params[:limit].to_i)
      end

      render json: rows, each_serializer: Api::V1::FamilySerializer, adapter: :json_api, root: false

    else
      render json: {
        status: 404
      }
    end

  end

  private

  def hash_params
    h = {}
    if params[:state] != nil
      h[:state] = params[:state]
    end
    if params[:city] != nil
      h[:city] = params[:city]
    end
    if params[:last_name] != nil
      h[:last_name] = params[:last_name]
    end
    if params[:type] == "physician"
      if params[:speciality] != nil
        h[:speciality] = params[:speciality]
      end
    end
    return h
  end

end
