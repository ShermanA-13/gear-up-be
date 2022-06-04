class AddAreaToTrip < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :area, foreign_key: true
  end
end
