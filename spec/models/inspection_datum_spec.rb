require 'rails_helper'

describe InspectionDatum do
  describe "#create" do
    #1
    it "length, width, weight, comment, product_id, user_idが存在すれば登録できる" do
      inspection_datum = build(:inspection_datum)
      expect(inspection_datum).to be_valid
    end

    #2
    it "lengthが無い場合は登録できない" do
      inspection_datum = build(:inspection_datum, length: nil)
      inspection_datum.valid?
      expect(inspection_datum.errors[:length]).to include("can't be blank")
    end

    #3
    it "widthが無い場合は登録できない" do
      inspection_datum = build(:inspection_datum, width: nil)
      inspection_datum.valid?
      expect(inspection_datum.errors[:width]).to include("can't be blank")
    end

    #4
    it "weightが無い場合は登録できない" do
      inspection_datum = build(:inspection_datum, weight: nil)
      inspection_datum.valid?
      expect(inspection_datum.errors[:weight]).to include("can't be blank")
    end

    #5
    it "commentが無い場合は登録できない" do
      inspection_datum = build(:inspection_datum, comment: nil)
      inspection_datum.valid?
      expect(inspection_datum.errors[:comment]).to include("can't be blank")
    end

    #6
    it "product_idが無い場合は登録できない" do
      inspection_datum = build(:inspection_datum, product_id: nil)
      inspection_datum.valid?
      expect(inspection_datum.errors[:product]).to include("must exist")
    end

    #7
    it "user_idが無い場合は登録できない" do
      inspection_datum = build(:inspection_datum, user_id: nil)
      inspection_datum.valid?
      expect(inspection_datum.errors[:user]).to include("must exist")
    end

    #8
    it "重複したproduct_idのinspection_datumが既に存在している場合は登録できない" do
      inspection_datum = create(:inspection_datum)
      another_inspection_datum = build(:inspection_datum, product_id: inspection_datum.product_id)
      another_inspection_datum.valid?
      expect(another_inspection_datum.errors[:product_id]).to include("has already been taken")
    end

    #9
    # it "current_userのidが2の場合は登録できない" do
    #   inspection_datum = build(:inspection_datum, )
    #   inspection_datum.valid?
    #   expect(inspection_datum.errors[:]).to include("must exist")
    # end
    # 登録できるuserの制限を設定する事

  end
end
