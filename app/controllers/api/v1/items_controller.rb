class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_user

  def index
    render json: ItemSerializer.new(@user.items)
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create
    require "pry"; binding.pry
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    else
      database_error(item)
    end
  end

  def update
    @item.update(item_params)
    if @item.save
      render json: ItemSerializer.new(@item), status: 201
    else
      database_error(@item)
    end
  end

  def destroy
    @item.destroy
    render status: 204
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :count, :category, :user_id)
  end
end
