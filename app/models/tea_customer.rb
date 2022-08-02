class TeaCustomer < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true
  validates :customer_id, presence: true
  validates :tea_id, presence: true

  belongs_to :customer
  belongs_to :tea

  enum status: { active: 0, cancelled: 1 }
  enum frequency: { monthly: 0, bi_weekly: 1, weekly: 2 }
end
