require "test_helper"

describe "TripsController" do
  let(:passenger) { Passenger.all.sample }
  let(:driver) { Driver.all.sample }
  describe "create" do
    # it "creates the generated trip" do
    #   trip_data = {
    #     trip: {
    #       cost: 10,
    #       date: Time.now,
    #       price: rand(1.00..300.00).round(2),
    #       passenger_id: passenger.id,
    #       driver_id: driver.id,
    #     },
    #   }

    #   expect {
    #     post passenger_trips_path(trip_data[:passenger_id]), params: trip_data
    #   }.must_change "Trip.count", +1
    # end
  end

  describe "edit" do
    it "allows you to edit a trip" do
    end
  end

  describe "update" do
    it "# Your tests go here" do
    end
  end

  describe "show" do
    it "# Your tests go here" do
    end
  end

  describe "destroy" do
    it "# Your tests go here" do
    end
  end
end
