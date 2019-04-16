class PassengersController < ApplicationController
  def index
    @passenger = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    unless @passenger
      head :not_found
      redirect_to passengers_path
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    successful = @passenger.save
    if successful
      redirect_to passengers_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    unless @passenger
      redirect_to passengers_path
    end
  end

  def update
    @passenger = Passenger.fund_by(id: params[:id])
    unless @passenger
      redirect_to passengers_path
    end
    passenger.update!(task_params)
    redirect_to passenger_path(passenger)
  end

  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    unless @passenger
      head :not_found
      return
    end
    @passenger.destroy
    redirect_to passengers_path
  end

  def request_trip
    @passenger = Passenger.find_by(id: params[:id])
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
