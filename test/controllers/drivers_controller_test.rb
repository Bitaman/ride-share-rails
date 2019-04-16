require "test_helper"

describe DriversController do
  let(:driver) { Driver.create(name: "Jeremy Woburn", vin: 2001222) }

  describe "index" do
    it "drivers index renders without crashing" do
      Driver.create!(name: "Ted Willy", vin: 2)

      get drivers_path

      must_respond_with :ok
    end

    it "will render even with zero drivers" do 
      Driver.destroy_all

      get drivers_path

      must_respond_with :ok
    end
  end

  describe "show" do
    it "works when given a driver id that exists" do
      get driver_path(driver)

      must_respond_with :ok
    end

    it "returns 404 not found when given a non extant id" do 
      driver_id = 1337

      get driver_path(driver_id)
    
      must_respond_with :not_found
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
