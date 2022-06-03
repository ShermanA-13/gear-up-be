# frozen_string_literal: true

class CreateTripUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_users do |t|
      t.references :trip, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :host

      t.timestamps
    end
  end
end
