require 'rails_helper'

describe ProductionImage do
  describe "#create" do
    it "imageが存在すれば登録できる" do
      production_image = build(:production_image)
      expect(production_image).to be_valid
    end

    it "imageが無い場合は登録できない" do
      production_image = build(:production_image, image: nil)
      production_image.valid?
      expect(production_image.errors[:image]).to include("can't be blank")
    end

    it "production_datum_idが無い場合は登録できない" do
      production_image = build(:production_image, production_datum_id: nil)
      production_image.valid?
      expect(production_image.errors[:production_datum]).to include("must exist")
    end
  end
end
