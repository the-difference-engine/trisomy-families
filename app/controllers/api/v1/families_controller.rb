class Api::V1::FamiliesController < ApplicationController

  def index
    @families = Family.all
    render 'index.json.jbuilder'
  end

  def children
    @children = Child.all
    render 'children.json.jbuilder'
  end

end