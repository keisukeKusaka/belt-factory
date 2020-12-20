# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :search, :all
    can :filter, :all

    if user.department_id == 1
      can [:create, :update, :destroy], [ProductionDatum, InspectionDatum]
    end

    if user.department_id == 2
      can [:create, :update, :destroy], [Product, EvaluationDatum]
    end
  end
end
