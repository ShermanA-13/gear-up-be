class Api::V1::TripItemsController < ApplicationController
  before_action :set_trip, only: [:create]
  def index
    render json: TripItemSerializer.new(TripItem.where("trip_id = ?", params[:trip_id]))
  end

  def create
    trip_items = params[:items].map do |id|
      TripItem.create(item_id: id, trip_id: @trip.id)
    end
    render json: TripItemSerializer.new(trip_items), status: :created
  end

  def destroy
    trip_item = TripItem.find(params[:trip_item_id])
    trip_item.destroy
    render status: 204
  end

  private

  def trip_item_params
    params.require(:trip_item).permit(:trip_id, :item_id)
  end
end
