class Product < ApplicationRecord
  belongs_to :client
  belongs_to :material
  belongs_to :user
  has_one :production_datum
  has_one :inspection_datum

  validates :number, presence: true, uniqueness: true
end
