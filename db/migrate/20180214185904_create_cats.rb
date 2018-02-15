class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|

      t.timestamps
    end
  end
end
