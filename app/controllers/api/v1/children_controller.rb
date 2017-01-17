class Api::V1::ChildrenController < ApplicationController
  def index
    @children = Child.all
  end
end