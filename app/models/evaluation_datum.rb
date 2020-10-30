class EvaluationDatum < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :evaluation_images
  accepts_nested_attributes_for :evaluation_images, allow_destroy: true

  validates :comment, presence: true
  validates :product_id, uniqueness: true
end
