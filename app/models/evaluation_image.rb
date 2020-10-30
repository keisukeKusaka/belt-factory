class EvaluationImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :evaluation_datum
  validates :image, presence: true
end
