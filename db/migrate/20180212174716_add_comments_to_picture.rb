class AddCommentsToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :comments, :text
  end
end
