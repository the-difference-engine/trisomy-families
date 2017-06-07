class Api::V1::ResourcesController < ApplicationController

  def index
    @resources = Resource.all
    render 'index.json.jbuilder'
  end

  def new
  end

  def edit
    
  end

  def destroy
    
  end

  

end