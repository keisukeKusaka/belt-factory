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

  def self.production_guest
    find_or_create_by!(number: "990001") do |user|
      user.name = "テストユーザー(製造)"
      user.department_id = 1
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.sales_guest
    find_or_create_by!(number: "990002") do |user|
      user.name = "テストユーザー(営業)"
      user.department_id = 2
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
