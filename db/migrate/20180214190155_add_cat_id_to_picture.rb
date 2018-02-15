class AddCatIdToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :cat_id, :integer
  end
end
