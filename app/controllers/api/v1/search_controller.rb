# SearchController
# might need to add error exceptions throughout controller
class Api::V1::SearchController < ApplicationController
  def index
    if params[:type] == 'physician'
      rows = Physician.where(hash_params)
      if !params[:limit].nil?
        rows = rows.limit(params[:limit].to_i)
      end
      if !params[:fields].nil?
        fields_array = []
        params[:fields].split(',').each do |attr|
          fields_array.push(attr.to_sym)
        end
        # bug - id is returned even if ommitted
        render json: rows, fields: { physician: fields_array }, each_serializer: Api::V1::PhysicianSerializer, adapter: :json_api, root: false
      else
        render json: rows, each_serializer: Api::V1::PhysicianSerializer, adapter: :json_api, root: false
      end

    elsif params[:type] == 'family'
      if !params[:trisomy_type].nil?
        families = Family.all
        family_rows = []
        families.each do |family|
          if family.children != nil
            family.children.each do |child|
              if child.trisomy_type == params[:trisomy_type]
                family_rows << family
              end
            end
          end
        end
      else
        family_rows = Family.where(hash_params)
      end
      @families = family_rows
      render 'families.json.jbuilder'
    else
      render json: { status: 404, error: "Not found"}, status: 404
    end
  end

  private

  def hash_params
    h = {}
    if !params[:id].nil?
      h[:id] = params[:id]
    end
    if !params[:state].nil?
      h[:state] = params[:state]
    end
    if !params[:city].nil?
      h[:city] = params[:city]
    end
    if !params[:last_name].nil?
      h[:last_name] = params[:last_name]
    end
    if params[:type] == 'physician'
      if !params[:specialty].nil?
        h[:specialty] = params[:specialty]
      end
    end
    h
  end
end
