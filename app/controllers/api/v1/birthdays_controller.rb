class Api::V1::BirthdaysController < ApplicationController

  def index
    @children = Child.where('extract(month from birth_date) = ? AND extract(day from birth_date) = ?', '01', '01')
    render 'index.json.jbuilder'
  end

end