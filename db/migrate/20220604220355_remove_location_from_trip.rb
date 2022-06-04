class RemoveLocationFromTrip < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :location, :string
  end
end
