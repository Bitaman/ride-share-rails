class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :cost, presence: true
  validates :date, presence: true
  validates :passenger, presence: true
  validates :driver, presence: true
end
