class AddPictureIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :picture_id, :integer
    add_index :comments, :picture_id
  end
end
