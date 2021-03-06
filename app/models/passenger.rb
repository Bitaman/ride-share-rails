class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_amount
    total = 0
    self.trips.each do |trip|
      total += trip.cost
    end
    return total
  end
end
