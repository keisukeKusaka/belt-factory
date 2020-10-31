require 'rails_helper'

describe InspectionImage do
  describe "#create" do
    it "imageが存在すれば登録できる" do
      inspection_image = build(:inspection_image)
      expect(inspection_image).to be_valid
    end

    it "imageが無い場合は登録できない" do
      inspection_image = build(:inspection_image, image: nil)
      inspection_image.valid?
      expect(inspection_image.errors[:image]).to include("can't be blank")
    end

    it "inspection_datum_idが無い場合は登録できない" do
      inspection_image = build(:inspection_image, inspection_datum_id: nil)
      inspection_image.valid?
      expect(inspection_image.errors[:inspection_datum]).to include("must exist")
    end
  end
end
