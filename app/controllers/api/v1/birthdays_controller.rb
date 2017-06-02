class Api::V1::BirthdaysController < ApplicationController

  def index
    month = Date.today.strftime('%m')
    day = Date.today.strftime('%d')
    @children = Child.where('extract(month from birth_date) = ? AND extract(day from birth_date) = ?', month, day)
    render 'index.json.jbuilder'
  end

end