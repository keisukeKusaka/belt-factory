class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :validatable
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true

  belongs_to :department
  has_many :products
  has_many :production_data
  has_many :inspection_data

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
