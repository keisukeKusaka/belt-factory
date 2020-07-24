require 'rails_helper'

describe ProductionDatum do
  describe "#create" do
    #1
    it "comment, product_id, user_idが存在すれば登録できる" do
      production_datum = build(:production_datum)
      expect(production_datum).to be_valid
    end

    #2
    it "commentが無い場合は登録できない" do
      production_datum = build(:production_datum, comment: nil)
      production_datum.valid?
      expect(production_datum.errors[:comment]).to include("can't be blank")
    end

    #3
    it "product_idが無い場合は登録できない" do
      production_datum = build(:production_datum, product_id: nil)
      production_datum.valid?
      expect(production_datum.errors[:product]).to include("must exist")
    end

    #4
    it "user_idが無い場合は登録できない" do
      production_datum = build(:production_datum, user_id: nil)
      production_datum.valid?
      expect(production_datum.errors[:user]).to include("must exist")
    end

    #5
    # it "重複したproduct_idのproduction_datumが既に存在している場合は登録できない" do
    #   production_datum = create(:production_datum)
    #   another_production_datum = build(:production_datum, product_id: production_datum.product_id)
    #   another_production_datum.valid?
    #   expect(another_production_datum.errors[:product_id]).to include("has already been taken")
    # end
    # product_idにバリデーションをかける事

    #6
    # it "current_userのidが2の場合は登録できない" do
    #   production_datum = build(:production_datum, )
    #   production_datum.valid?
    #   expect(production_datum.errors[:]).to include("must exist")
    # end
    # 登録できるuserの制限を設定する事
  end
end
