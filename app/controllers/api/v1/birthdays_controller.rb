class Api::V1::BirthdaysController < ApplicationController

  def index
    @children = Child.all
    render 'index.json.jbuilder'
  end

end