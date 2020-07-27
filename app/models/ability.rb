# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :search, :all

    if user.department_id == 1
      can :create, [ProductionDatum, InspectionDatum]
      cannot :create, [Product, EvaluationDatum]
    end

    if user.department_id == 2
      can :create, [Product, EvaluationDatum]
      cannot :create, [ProductionDatum, InspectionDatum]
    end
  end
end
