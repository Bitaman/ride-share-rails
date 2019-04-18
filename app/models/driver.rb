class Driver < ApplicationRecord
  has_many :trips, dependency: :nullify

  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
    totals = 0
    self.trips.each do |trip|
      trip_dollars = (((trip.cost * 0.01) * 0.8) - 1.65)
      totals += trip_dollars
    end

    return totals.round(2)
  end

  def average_rating
    if self.trips != []
      rating = 0
      trips = self.trips.length

      self.trips.each do |trip|
        rating += trip.rating
      end
      average_rating = rating / trips
      return average_rating
    else
      return "Ratings unavailable."
    end
  end
end
