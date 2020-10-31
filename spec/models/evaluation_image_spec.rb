require 'rails_helper'

describe EvaluationImage do
  describe "#create" do
    it "imageが存在すれば登録できる" do
      evaluation_image = build(:evaluation_image)
      expect(evaluation_image).to be_valid
    end

    it "imageが無い場合は登録できない" do
      evaluation_image = build(:evaluation_image, image: nil)
      evaluation_image.valid?
      expect(evaluation_image.errors[:image]).to include("can't be blank")
    end

    it "evaluation_datum_idが無い場合は登録できない" do
      evaluation_image = build(:evaluation_image, evaluation_datum_id: nil)
      evaluation_image.valid?
      expect(evaluation_image.errors[:evaluation_datum]).to include("must exist")
    end
  end
end
