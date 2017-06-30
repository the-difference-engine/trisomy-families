# API/V1/ChildrenController
class Api::V1::ChildrenController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @children = Child.all
    render 'index.json.jbuilder'
  end

  def trisomy_type_totals
    all_children = Child.all
    @trisomy_types = []
    @trisomy_types_hash = Hash.new
    all_children.each do |child|
      @trisomy_types << child.trisomy_type
    end

    @trisomy_types.each do |trisomy_type|
      @trisomy_types_hash[trisomy_type] =+ 1
    end

    @trisomy_types.each_with_object(@trisomy_types_hash) { |word,counts| counts[word] += 1 }

    @trisomy_types_hash.each do |key, value|
      @trisomy_types_hash[key] = value - 1
    end

    render 'index2.json.jbuilder'
  end

  def birth_order_totals
    all_children = Child.all
    @birth_order_array = []
    @birth_order_hash = Hash.new
    all_children.each do |child|
      @birth_order_array << child.birth_order
    end

    @birth_order_array.each do |birth_order|
      @birth_order_hash[birth_order] =+ 1
    end

    @birth_order_array.each_with_object(@birth_order_hash) { |word,counts| counts[word] += 1 }

    @birth_order_hash.each do |key, value|
      @birth_order_hash[key] = value - 1
    end

    render 'index3.json.jbuilder'
  end

  def update
    @child = Child.find_by(id: params[:id])
    if params["accepted"] == "Accept Child"
      @child.update(
        accepted: true
      )
      @child.save
      redirect_to '/children-index'
    end
  end
end
