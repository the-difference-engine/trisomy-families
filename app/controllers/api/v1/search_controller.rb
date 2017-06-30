# SearchController
# might need to add error exceptions throughout controller
class Api::V1::SearchController < ApplicationController
  def index
    if params[:type] == 'physician'
      rows = Physician.where(phys_hash_params)
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

      if params[:state].nil? && params[:trisomy_type].nil?
        families = Family.all
      elsif !params[:state].nil? && params[:trisomy_type].nil?
        families = Family.where(state: params[:state])
      elsif params[:state].nil? && !params[:trisomy_type].nil?
        families = Family.all.reject { |n| !n.children.include?(n.children.find_by(trisomy_type: params[:trisomy_type])) }
      elsif !params[:state].nil? && !params[:trisomy_type].nil?
        families = Family.where(state: params[:state]).reject { |n| !n.children.include?(n.children.find_by(trisomy_type: params[:trisomy_type])) }
      else
        families = []
      end

      if !params[:last_name].nil?
        family_name = params[:last_name].downcase
        families = Family.where('lower(family_name) = ?', family_name)
      end

      @families = families

      render 'families.json.jbuilder'
    else
      render json: { status: 404, error: "Not found"}, status: 404
    end
  end

  private

  def phys_hash_params
    h = {}
    if !params[:state].nil?
      h[:state] = params[:state]
    end
    if !params[:specialty].nil?
      h[:specialty] = params[:specialty]
    end
    if !params[:last_name].nil?
      # capitalize last name
      h[:last_name] = params[:last_name]
    end
    h
  end

end
