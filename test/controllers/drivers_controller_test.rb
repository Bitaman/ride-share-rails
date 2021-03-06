require "test_helper"

describe DriversController do
  before do
    @driver = Driver.create!(name: "Jeremy Woburn", vin: 2001222)
  end

  describe "index" do
    it "renders drivers index without crashing" do
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
      
      get driver_path(@driver.id)

      must_respond_with :ok
    end

    it "returns 404 not found when given a non extant id" do 
      driver_id = Driver.last.id + 1

      get driver_path(driver_id)
    
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "will show the form for editing a driver" do 
      get edit_driver_path(@driver)

      must_respond_with :ok
    end 

    it "will respond with 404 if not found" do
      driver_id = Driver.last.id + 1

      get edit_driver_path(driver_id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:driver_data) {
      {
        driver: {
          name: "changed name"
        },
      }
    }

    it "successfully makes updates to a driver" do 
      @driver.assign_attributes(driver_data[:driver])
      expect(@driver).must_be :valid?
      @driver.reload 

      patch driver_path(@driver), params: driver_data
      
      must_respond_with :redirect
      must_redirect_to driver_path(@driver)

      @driver.reload

      expect(@driver.name).must_equal driver_data[:driver][:name]
    end

    it "displays 404 for nonexistant driver" do 
      driver_id = Driver.last.id + 1

      patch driver_path(driver_id), params: driver_data

      must_respond_with :not_found
      # assert_template :edit

    end

    it "renders edit form for invalid parameters" do 
      driver_data[:driver][:name] = ""

      @driver.assign_attributes(driver_data[:driver])
      expect(@driver).wont_be :valid?
      @driver.reload

      patch driver_path(@driver), params: driver_data

      must_respond_with :bad_request
    end
  end

  describe "new" do
    it "renders the form to add a driver" do 
      get new_driver_path

      must_respond_with :ok
    end
  end

  describe "create" do
    it "will successfully add a driver to list" do
      driver_params = {
        driver: {
          name: "Theo Leo",
          vin: 12345,
        },
      }

      expect {
        post drivers_path, params: driver_params
      }.must_change 'Driver.count', +1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "will send bad request if invalid params are passed" do
      driver_params = {
        driver: {
          name: "",
          vin: 12345
        }
      } 

      expect {
        post drivers_path, params: driver_params
      }.wont_change "Driver.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "can remove a driver from the list" do 
      driver = Driver.last
      
      expect {
        delete driver_path(driver)
      }.must_change 'Driver.count', -1

      deleted_driver = Driver.find_by(id: driver.id)
      expect(deleted_driver).must_be_nil

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "sends a 404 if driver not found" do 
      driver_id = 1337

      expect {
        delete driver_path(driver_id)
      }.wont_change "Driver.count"

      must_respond_with :not_found
    end
  end

  describe "availability toggle" do 
    it "allows a driver to toggle online/offline " do 
      

      driver_id = @driver.id
      patch toggle_available_path(driver_id)
      @driver.reload

      expect(@driver.available).must_equal false

      patch toggle_available_path(driver_id)
      @driver.reload

      expect(@driver.available).must_equal true
    end

  end
end
