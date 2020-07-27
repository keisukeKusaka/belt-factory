require 'rails_helper'

describe EvaluationDatum do
  describe "#create" do
    #1
    it "comment, product_id, user_idが存在すれば登録できる" do
      evaluation_datum = build(:evaluation_datum)
      expect(evaluation_datum).to be_valid
    end

    #2
    it "commentが無い場合は登録できない" do
      evaluation_datum = build(:evaluation_datum, comment: nil)
      evaluation_datum.valid?
      expect(evaluation_datum.errors[:comment]).to include("can't be blank")
    end

    #3
    it "product_idが無い場合は登録できない" do
      evaluation_datum = build(:evaluation_datum, product_id: nil)
      evaluation_datum.valid?
      expect(evaluation_datum.errors[:product]).to include("must exist")
    end

    #4
    it "user_idが無い場合は登録できない" do
      evaluation_datum = build(:evaluation_datum, user_id: nil)
      evaluation_datum.valid?
      expect(evaluation_datum.errors[:user]).to include("must exist")
    end

    #5
    it "重複したproduct_idのevaluation_datumが既に存在している場合は登録できない" do
      evaluation_datum = create(:evaluation_datum)
      another_evaluation_datum = build(:evaluation_datum, product_id: evaluation_datum.product_id)
      another_evaluation_datum.valid?
      expect(another_evaluation_datum.errors[:product_id]).to include("has already been taken")
    end
  end
end
