class Tea < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, numericality: true, presence: true
  validates :brew_time, presence: true
end
