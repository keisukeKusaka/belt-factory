class ProductionImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :production_datum
  validates :image, presence: true
end
