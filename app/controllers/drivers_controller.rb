class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def new # form, needs a view
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    successful = @driver.save
    if successful
      redirect_to drivers_path
    else
      render :new, status: :bad_request
    end
  end

  def show # shows a view
    @driver = Driver.find_by(id: params[:id])

    unless @driver
      head :not_found
    end
  end

  def edit # form, needs a view to update info on a driver
    @driver = Driver.find_by(id: params[:id])

    unless @driver
      head :not_found
    end
  end

  def update # takes info from form, doesn't need @
    @driver = Driver.find_by(id: params[:id])

    unless @driver
      head :not_found
      return
    end

    if @driver.update(driver_params)
      redirect_to driver_path(@driver)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy # removes a driver from list of drivers
    driver = Driver.find_by(id: params[:id])

    unless driver
      head :not_found
      return
    end

    driver.destroy

    redirect_to drivers_path
  end

  def toggle_available
    driver = Driver.find_by(id: params[:id])

    unless driver
      redirect_to drivers_path
      return
    end

    if driver.available
      driver.update(available: false)
    else
      driver.update(available: true)
    end

    redirect_to driver_path
  end

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
