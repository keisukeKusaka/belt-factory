# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :search, :all

    if user.department_id == 1
      can :create, [ProductionDatum, InspectionDatum]
    end

    if user.department_id == 2
      can :create, [Product, EvaluationDatum]
    end
  end
end
