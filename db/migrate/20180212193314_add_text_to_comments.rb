class AddTextToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :text, :text
  end
end
