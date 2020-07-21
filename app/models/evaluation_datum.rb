class EvaluationDatum < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :comment, presence: true

  mount_uploader :image, ImageUploader
end
