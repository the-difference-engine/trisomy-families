# API/V1/ChildrenController
class Api::V1::ChildrenController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @children = Child.all
    render 'index.json.jbuilder'
  end

  def update
    @children = Child.includes(background_history: [:weight, :height, :head_circumference, :mother_complication], health_history: [:congenital_heart_defect, :intestinal_issue, :gastric_surgery, :nuerological_condition, :muscular_skeletal, :cranial_facial, :endocrine, :hearing, :vision, :behavioral_health, :received_therapy]).where.not({health_history_id: nil, background_history_id: nil})
    @child = Child.find_by(id: params[:id])
    @child.update(
      accepted: params[:accepted]
    )
    @child.save(validate: false)
  end
end
