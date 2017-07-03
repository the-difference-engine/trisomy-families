# SearchController
# might need to add error exceptions throughout controller
class Api::V1::SearchController < ApplicationController
  def index
    if params[:type] == 'physician'
      if !params[:last_name].nil? && params[:state].nil?
        phys_last_name = params[:last_name].downcase        
        physicians = Physician.where('lower(last_name) = ?', phys_last_name)      
      elsif params[:last_name].nil? && !params[:state].nil?
        physicians = Physician.where(state: params[:state])
      elsif params[:last_name].nil? && params[:state].nil?
        physicians = Physician.all
      elsif !params[:last_name].nil? && !params[:state].nil?
        last_name = params[:last_name].downcase
        physicians = Physicians.where('lower(last_name) = ?', last_name)
      else 
        physicians == []
      end

      @physicians = physicians
      render 'physicians.json.jbuilder'

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
      h[:last_name] = params[:last_name]
    end
    h
  end

end
