class AddAddressToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :address, :string
  end
end
