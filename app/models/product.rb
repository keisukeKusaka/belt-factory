class Product < ApplicationRecord
  belongs_to :client
  belongs_to :material
  belongs_to :user

  validates :number, presence: true, uniqueness: true
end
