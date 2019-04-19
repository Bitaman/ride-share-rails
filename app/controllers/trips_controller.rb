class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id]

    @trip = Trip.find_by(id: trip_id)

    unless @trip
      head :not_found
    end
  end

  def create
    @trip = Trip.create!(cost: 10, date: Time.now, driver_id: Driver.all.sample.id, passenger_id: params[:passenger_id])

    if @trip
      redirect_to trip_path(@trip.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    trip_id = params[:id]

    @trip = Trip.find_by(id: trip_id)

    unless @trip
      head :not_found
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    unless @trip
      head :not_found
      return
    end

    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    trip_id = params[:id]

    trip = Trip.find_by(id: trip_id)

    unless trip
      head :not_found
      return
    end

    trip.destroy

    redirect_to passenger_path
  end

  def completed_trip
    passenger_id = params[:id]
    trip = Trip.find_by(passenger_id: passenger_id, rating: nil)
    succesful = trip.update(rating: params[:rating])

    if succesful
      redirect_to passenger_path
    else
      head :bad_request
      return
    end
  end

  def trip_params
    return params.require(:trip).permit(:rating, :cost, :date, :passenger, :driver)
  end
end
