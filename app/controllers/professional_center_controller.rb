class ProfessionalCenterController < ApplicationController
  def index
    @children = Unirest.get('http://localhost:3000/api/v1/children.json').body
    render 'index.html.erb'
  end
end
