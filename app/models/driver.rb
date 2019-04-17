class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  total = 0
  def total_earnings
    self.trips.each do |trip|
      total += (trip.cost * 0.8) - 1.65
    end
    return total
  end
end
