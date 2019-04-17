class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  
  # def total_earnings
  #   totals = []
  #   self.trips.each do |trip|
  #    totals << ((trip.cost * 0.8) - 1.65)
  #   end
    
  #   return totals.sum
  # end

  def total_earnings
    totals = 0
    self.trips.each do |trip|
     trip_dollars = (((trip.cost * 0.01 )* 0.8) - 1.65)
      totals << trip_dollars
    end
    
    return totals.sum
  end
end
