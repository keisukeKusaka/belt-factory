class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :validatable
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true, length: { is: 6 }, format: { with: /\A[0-9]{6}\z/ }
  validates :password, format: { with: /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/}

  belongs_to :department
  has_many :products
  has_many :production_data
  has_many :inspection_data
  has_many :evaluation_data

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
