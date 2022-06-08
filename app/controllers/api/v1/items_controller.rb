class Api::V1::ItemsController < ApplicationController

  def index
    if valid_params?(User, params[:user_id], "user")
      render json: ItemSerializer.new(@object.items)
    end
  end

  def show
    if valid_params?(User, params[:user_id], "user") && valid_params?(Item, params[:item_id], "item")
      render json: ItemSerializer.new(@object)
    end
  end

  def create
    if valid_params?(User, params[:user_id], "user")
      item = Item.new(item_params)
      if item.save
        render json: ItemSerializer.new(item), status: :created
      else
        database_error(item)
      end
    end
  end

  def update
    if valid_params?(User, params[:user_id], "user") && valid_params?(Item, params[:item_id], "item")
      @object.update(item_params)
      if @object.save
        render json: ItemSerializer.new(@object), status: 201
      else
        database_error(@object)
      end
    end
  end

  def destroy
    if valid_params?(User, params[:user_id], "user") && valid_params?(Item, params[:item_id], "item")
      @object.destroy
      render status: 204
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :count, :category, :user_id)
  end
end
