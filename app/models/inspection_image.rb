class InspectionImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :inspection_datum
  validates :image, presence: true
end
