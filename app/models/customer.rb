class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address, presence: true

  has_many :tea_customers
  has_many :teas, through: :tea_customers
end
