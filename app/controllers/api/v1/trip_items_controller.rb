class Api::V1::TripItemsController < ApplicationController
  before_action :set_trip, only: [:create, :index, :update, :show]
  before_action :set_user, only: [:index, :update]

  def index
    items = @user.items_on_trip(params[:trip_id])
    render json: ItemSerializer.new(items)
  end

  def show
    render json: TripItemSerializer.new(@trip.trip_items)
  end

  def create
    if params[:items].nil?
      render json: TripSerializer.new(@trip)
    else
      items = trip_items_create(params[:items])
      render json: TripItemSerializer.new(items), status: :created
    end
  end

  def destroy
    trip_item = TripItem.find(params[:trip_item_id])
    trip_item.destroy
    render status: 204
  end

  def update
    if !params[:items].nil?
      create_missing_trip_items(params[:items])
      remove_extra_trip_items
      # @user.missing_trip_items(params[:items], @trip).each { |item| item.destroy }
    else
      @user.trip_items_delete(@trip.id).each {|item| item.destroy}
    end
    render json: TripSerializer.new(@trip), status: 200
  end

  private

  def trip_item_params
    params.require(:trip_item).permit(:trip_id, :item_id)
  end

  def create_missing_trip_items(items)
    items.each do |item|
      if !TripItem.exists?(item_id: item, trip_id: @trip.id)
        TripItem.create(trip_id: @trip.id, item_id: item)
      end
    end
  end

  def trip_items_create(items)
    items.map {|id| TripItem.create(item_id: id, trip_id: @trip.id) }
  end

  def remove_extra_trip_items
    @user.missing_trip_items(params[:items], @trip).each { |item| item.destroy }
  end
end
