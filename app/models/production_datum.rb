class ProductionDatum < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :production_images
  accepts_nested_attributes_for :production_images, allow_destroy: true

  validates :comment, presence: true
  validates :product_id, uniqueness: true
end
