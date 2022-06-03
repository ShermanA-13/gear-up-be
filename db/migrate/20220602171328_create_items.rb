# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :count
      t.integer :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
