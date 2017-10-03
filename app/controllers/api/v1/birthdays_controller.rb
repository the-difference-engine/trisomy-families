class Api::V1::BirthdaysController < ApplicationController

  def index
    month = params[:userMonth].to_i
    day = params[:userDay].to_i
    @children = Child.where('extract(month from birth_date) = ? AND extract(day from birth_date) = ?', month, day)
    render 'index.json.jbuilder'
  end

end