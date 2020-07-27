require 'rails_helper'

describe Ability do
  #1
  it "current_userのdepartment_idが1の場合はproductを登録できない" do
    user = build(:user, department_id: 1)
    ability = Ability.new(user)
    assert ability.cannot?(:create, Product.new)
  end

  #2
  it "current_userのdepartment_idが1の場合はevaluation_datumを登録できない" do
    user = build(:user, department_id: 1)
    ability = Ability.new(user)
    assert ability.cannot?(:create, EvaluationDatum.create)
  end

  #3
  it "current_userのdepartment_idが2の場合はproduction_datumを登録できない" do
    user = build(:user, department_id: 2)
    ability = Ability.new(user)
    assert ability.cannot?(:create, ProductionDatum.create)
  end

  #4
  it "current_userのdepartment_idが2の場合はinspection_datumを登録できない" do
    user = build(:user, department_id: 2)
    ability = Ability.new(user)
    assert ability.cannot?(:create, InspectionDatum.create)
  end

  #5
  it "全てのuserはproductを検索できる" do
    product = create(:product)
    user = build(:user)
    ability = Ability.new(user)
    assert ability.can?(:search, Product.find_by(number: product.number))
  end

  #6
  it "全てのuserはproductを閲覧できる" do
    product = create(:product)
    user = build(:user)
    ability = Ability.new(user)
    assert ability.can?(:read, Product.find(product.id))
  end
end
