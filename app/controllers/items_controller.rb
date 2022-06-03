class ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where("user_id = ?", params[:user_id]))
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:item_id]))
  end
end
