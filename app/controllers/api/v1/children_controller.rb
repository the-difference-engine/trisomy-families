# API/V1/ChildrenController
class Api::V1::ChildrenController < ApplicationController
  def index
    @children = Child.where.not({health_history_id: nil, background_history_id: nil})
  end
end
