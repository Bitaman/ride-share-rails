require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.create!(name: "test passenger", phone_num: "phone number")
  end

  describe "index" do
    #Your tests go here
    it "can render" do
      get passengers_path
      must_respond_with :ok
    end
    it "will render even if we dont have any passenger" do
      #Arrange
      Passenger.destroy_all
      #Act
      get passengers_path
      #Assert
      must_respond_with :ok
    end
  end

  describe "show" do
    # Your tests go here
    it "return a 404 status code if the passenger does not exist" do
      passenger_id = -2
      get passenger_path(passenger_id)
      must_respond_with :not_found
    end
    it "render the show page for each passenger" do
      get passenger_path(@passenger.id)
      must_respond_with :ok
    end
  end

  describe "edit" do
    # Your tests go here
    it "responds with OK for a real passenger" do
      get edit_passenger_path(@passenger)
      must_respond_with :ok
    end
    it "responds with not found for a fake passenger" do
      passenger_id = Passenger.last.id + 1
      get edit_passenger_path(passenger_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:passenger_data) {
      {
        passenger: {
          name: "changed",
          phone_num: "changed",
        },
      }
    }
    # Your tests go here
    it "changes the data on the model" do
      # Assumptions
      @passenger.assign_attributes(passenger_data[:passenger])
      expect(@passenger).must_be :valid?
      @passenger.reload

      # Act
      patch passenger_path(@passenger), params: passenger_data

      # Assert
      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger)

      @passenger.reload
      expect(@passenger.name).must_equal(passenger_data[:passenger][:name])
      expect(@passenger.phone_num).must_equal(passenger_data[:passenger][:phone_num])
    end

    it "responds with NOT FOUND for a fake passenger" do
      passenger_id = Passenger.last.id + 1
      patch passenger_path(passenger_id), params: passenger_data
      must_respond_with :not_found
    end
  end

  describe "new" do
    # Your tests go here
    it "returns status code 200" do
      get new_passenger_path

      must_respond_with :ok
    end
  end

  describe "create" do
    # Your tests go here
    it "create a new passenger" do
      passenger_data = {
        passenger: {
          name: "new name",
          phone_num: "new phone",
        },
      }
      expect {
        post passengers_path, params: passenger_data
      }.must_change "Passenger.count", +1

      must_respond_with :redirect
      must_redirect_to passengers_path()

      passenger = Passenger.last
      expect(passenger.name).must_equal passenger_data[:passenger][:name]
      expect(passenger.phone_num).must_equal passenger_data[:passenger][:phone_num]
    end
  end

  describe "destroy" do
    # Your tests go here
    #Act
    it "removes the passenger from the database" do
      expect {
        delete passenger_path(@passenger)
      }.must_change "Passenger.count", -1
      #Assert
      must_respond_with :redirect
      must_redirect_to passengers_path
      deleted_passenger = Passenger.find_by(id: @passenger.id)
      expect(deleted_passenger).must_be_nil
    end

    it "respond with NOT FOUND when a passenger does not exist" do
      passenger_id = -3
      expect(Passenger.find_by(id: passenger_id)).must_be_nil
      expect {
        delete passenger_path(passenger_id)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end
end
