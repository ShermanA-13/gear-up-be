class ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where("user_id = ?", params[:user_id]))
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:item_id]))
  end

  def create
    render json: ItemSerializer.new(Item.create!(item_params)), status: :created
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :count, :category, :user_id)
  end
end
