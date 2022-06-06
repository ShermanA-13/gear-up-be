class Api::V1::AreasController < ApplicationController
  def find_all
    render json: AreaSerializer.new(Area.find_all_by_name(params[:name]))
  end
end
