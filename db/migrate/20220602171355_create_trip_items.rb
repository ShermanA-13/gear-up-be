# frozen_string_literal: true

class CreateTripItems < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_items do |t|
      t.references :trip, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
