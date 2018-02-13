class AddLatitudeAndLongitudeToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :latitude, :float
    add_column :pictures, :longitude, :float
  end
end
