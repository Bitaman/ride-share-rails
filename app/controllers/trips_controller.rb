class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    def show
      trip_id = params[:id]

      @trip = Trip.find_by(id: trip_id)

      unless @trip
        head :not_found
      end
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
end
