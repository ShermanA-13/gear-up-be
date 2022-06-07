class Api::V1::AreasController < ApplicationController
  def find_all
    render json: AreaSerializer.new(Area.find_all_by_name(params[:name]))
  end

  def show
    area = Area.find(params[:id])
    render json: AreaSerializer.new(area)
  end
end
