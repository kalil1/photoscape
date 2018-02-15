class AddNameToCat < ActiveRecord::Migration[5.1]
  def change
    add_column :cats, :name, :string
  end
end
