# API/V1/ChildrenController
class Api::V1::ChildrenController < ApplicationController
  def index
    @children = Child.includes(background_history: [:weight, :height, :head_circumference, :mother_complication], health_history: [:congenital_heart_defect, :intestinal_issue, :gastric_surgery, :nuerological_condition, :muscular_skeletal, :cranial_facial, :endocrine, :hearing, :vision, :behavioral_health, :received_therapy]).where.not({health_history_id: nil, background_history_id: nil})
  end
end
