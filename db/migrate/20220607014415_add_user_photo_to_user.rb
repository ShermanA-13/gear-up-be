class AddUserPhotoToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_photo, :string
  end
end
