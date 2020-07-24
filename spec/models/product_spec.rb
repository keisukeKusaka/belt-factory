require 'rails_helper'

describe Product do
  describe "#create" do
    #1
    it "number, length, width, client_id, material_id, user_idが存在すれば登録できる" do
      product = build(:product)
      expect(product).to be_valid
    end

    #2
    it "numberが無い場合は登録できない" do
      product = build(:product, number: nil)
      product.valid?
      expect(product.errors[:number]).to include("can't be blank")
    end

    #3
    it "lengthが無い場合は登録できない" do
      product = build(:product, length: nil)
      product.valid?
      expect(product.errors[:length]).to include("can't be blank")
    end

    #4
    it "widthが無い場合は登録できない" do
      product = build(:product, width: nil)
      product.valid?
      expect(product.errors[:width]).to include("can't be blank")
    end

    #5
    it "client_idが無い場合は登録できない" do
      product = build(:product, client_id: nil)
      product.valid?
      expect(product.errors[:client]).to include("must exist")
    end

    #6
    it "material_idが無い場合は登録できない" do
      product = build(:product, material_id: nil)
      product.valid?
      expect(product.errors[:material]).to include("must exist")
    end

    #7
    it "user_idが無い場合は登録できない" do
      product = build(:product, user_id: nil)
      product.valid?
      expect(product.errors[:user]).to include("must exist")
    end

    #8
    it "重複したnumberのproductが既に存在している場合は登録できない" do
      product = create(:product)
      another_product = build(:product, number: product.number)
      another_product.valid?
      expect(another_product.errors[:number]).to include("has already been taken")
    end

    #9
    # it "current_userのidが1の場合は登録できない" do
    #   product = build(:product, )
    #   product.valid?
    #   expect(product.errors[:]).to include("must exist")
    # end
    # productを登録できるuserの制限を設定する事

    #10
    it "numberに数字以外の文字が含まれる場合は登録できない" do
      product = build(:product, number: "test12")
      product.valid?
      expect(product.errors[:number]).to include("is invalid")
    end

    #11
    it "numberが5文字以下の場合は登録できない" do
      product = build(:product, number: "12345")
      product.valid?
      expect(product.errors[:number]).to include("is the wrong length (should be 6 characters)")
    end

    #12
    it "numberが7文字以上の場合は登録できない" do
      product = build(:product, number: "1234567")
      product.valid?
      expect(product.errors[:number]).to include("is the wrong length (should be 6 characters)")
    end
  end
end
