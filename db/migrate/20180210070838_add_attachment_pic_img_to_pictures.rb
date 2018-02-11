class AddAttachmentPicImgToPictures < ActiveRecord::Migration[4.2]
  def self.up
    change_table :pictures do |t|
      t.attachment :pic_img
    end
  end

  def self.down
    remove_attachment :pictures, :pic_img
  end
end
