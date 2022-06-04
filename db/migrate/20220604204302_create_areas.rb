class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string :name
      t.string :state
      t.string :url
      t.string :long
      t.string :lat

      t.timestamps
    end
  end
end
