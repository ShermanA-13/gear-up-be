class Api::V1::ItemsController < ApplicationController

  def index
    if find_user(params[:user_id]).class == User
      render json: ItemSerializer.new(@user.items)
    end
  end

  def show
    if find_user(params[:user_id]).class == User && find_item(params[:item_id]).class == Item
      render json: ItemSerializer.new(@item)
    end
  end

  def create
    if find_user(params[:user_id]).class == User
      item = Item.new(item_params)
      if item.save
        render json: ItemSerializer.new(item), status: :created
      else
        database_error(item)
      end
    end
  end

  def update
    item = Item.find(params[:item_id])
    if item.update(item_params)
      render json: ItemSerializer.new(item), status: 201
    else
      render status: 404
    end
  end

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    render status: 204
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :count, :category, :user_id)
  end
end
