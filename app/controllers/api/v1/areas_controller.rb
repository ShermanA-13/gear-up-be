class Api::V1::AreasController < ApplicationController
  def find_all
    if params[:name].nil? || params[:name].empty?
      error = Error.new(400, "EMPTY SEARCH", "Search can not be empty")
      render json: ErrorSerializer.new(error).serialized_json, status: 400
    else
      render json: AreaSerializer.new(Area.find_all_by_name(params[:name]))
    end
  end

  def show
    area = Area.find(params[:id])
    render json: AreaSerializer.new(area)
  end
end
