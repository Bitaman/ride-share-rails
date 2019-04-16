class PassengersController < ApplicationController
  def index
    @passenger = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    unless @passenger
      head :not_found
      redirect_to main
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    unless params["passenger"]
      render :new,
             status: bad_request
      return
    end
    @passenger.save
    redirect_to passenger_path
  end

  private

  def strong_params
    return params.require(:task).permit(:name, :phone_num)
  end
end
