class InspectionDatum < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :length, :width, :weight, :comment, presence: true
  validates :product_id, uniqueness: true
  mount_uploader :image, ImageUploader
end
