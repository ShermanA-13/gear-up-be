class Api::V1::TripItemsController < ApplicationController
  def index
    render json: TripItemSerializer.new(TripItem.where("trip_id = ?", params[:trip_id]))
  end

  def create
    render json: TripItemSerializer.new(TripItem.create!(trip_item_params)), status: :created
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
