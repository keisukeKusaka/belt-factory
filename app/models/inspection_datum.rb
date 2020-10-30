class InspectionDatum < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :inspection_images
  accepts_nested_attributes_for :inspection_images, allow_destroy: true

  validates :length, :width, :weight, :comment, presence: true
  validates :product_id, uniqueness: true
end
