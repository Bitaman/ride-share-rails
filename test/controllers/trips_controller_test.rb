require "test_helper"

describe TripsController do

  # let(:passenger) { Passenger.all.sample }
  # let(:driver) { Driver.all.sample }
  describe "create" do
    before do
      @passenger = Passenger.create!(name: "test passenger", phone_num: "123456")
      @driver = Driver.create!(name: "test driver", vin: "vin")
    end
    
    it "creates a new trip" do
      # Arrange
      trip_data = {
        trip: {
          cost: 10,
          passenger_id: @passenger.id,
          driver_id: @driver.id,
          date: Time.now,
        },
      }

      # Act
      expect {
        post passenger_trips_path(@passenger.id), params: trip_data
      }.must_change "Trip.count", +1

      # Assert
      must_respond_with :redirect
      trip = Trip.last
      must_redirect_to trip_path(trip.id)

      expect(trip.passenger).must_equal @passenger
    end
  end

  describe "edit" do
    before do
      @passenger = Passenger.create!(name: "test passenger", phone_num: "123456")
      @driver = Driver.create!(name: "test driver", vin: "vin")
      @trip = Trip.create!(cost: 10, date: Time.now, driver_id: @driver.id, passenger_id: @passenger.id)
    end
    it "responds with OK for a real trip" do
      get edit_trip_path(@trip)
      must_respond_with :ok
    end
    it "responds with not found for a fake trip" do
      trip_id = Trip.last.id + 1
      get edit_trip_path(trip_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @passenger = Passenger.create!(name: "test passenger", phone_num: "123456")
      @driver = Driver.create!(name: "test driver", vin: "vin")
      @trip = Trip.create!(cost: 10, date: Time.now, driver_id: @driver.id, passenger_id: @passenger.id)
    end
    let(:trip_data) {
      {
        trip: {
          cost: 30,
        },
      }
    }
    it "changes the data on the model" do
      # Assumptions
      @trip.assign_attributes(trip_data[:trip])
      expect(@trip).must_be :valid?
      @trip.reload

      # Act
      patch trip_path(@trip), params: trip_data

      # Assert
      must_respond_with :redirect
      must_redirect_to trip_path(@trip)

      @trip.reload
      expect(@trip.cost).must_equal(trip_data[:trip][:cost])
    end

    it "responds with NOT FOUND for a fake trip" do
      trip_id = Trip.last.id + 1
      patch trip_path(trip_id), params: trip_data
      must_respond_with :not_found
    end

    it "responds with BAD REQUEST for bad data" do
      # Arrange
      trip_data[:trip][:cost] = ""

      # Assumptions
      @trip.assign_attributes(trip_data[:trip])
      expect(@trip).wont_be :valid?
      @trip.reload

      # Act
      patch trip_path(@trip), params: trip_data

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "show" do
    before do
      @passenger = Passenger.create!(name: "test passenger", phone_num: "123456")
      @driver = Driver.create!(name: "test driver", vin: "vin")
      @trip = Trip.create!(cost: 10, date: Time.now, driver_id: @driver.id, passenger_id: @passenger.id)
    end
    it "return a 404 status code if the trip does not exist" do
      trip_id = -2
      get trip_path(trip_id)
      must_respond_with :not_found
    end
    it "render the show page for each trip" do
      get trip_path(@trip.id)
      must_respond_with :ok
    end
  end

  describe "destroy" do
    before do
      @passenger = Passenger.create!(name: "test passenger", phone_num: "123456")
      @driver = Driver.create!(name: "test driver", vin: "vin")
      @trip = Trip.create!(cost: 10, date: Time.now, driver_id: @driver.id, passenger_id: @passenger.id)
    end

    #Act
    it "removes the trip from the database" do
      expect {
        delete trip_path(@trip)
      }.must_change "Trip.count", -1
      #Assert
      must_respond_with :redirect
      must_redirect_to passenger_path
      deleted_trip = Trip.find_by(id: @trip.id)
      expect(deleted_trip).must_be_nil
    end

    it "respond with NOT FOUND when a trip does not exist" do
      trip_id = -3
      expect(Trip.find_by(id: trip_id)).must_be_nil
      expect {
        delete trip_path(trip_id)
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end
  end
  describe "completed trip" do
  end
end
