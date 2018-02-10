class Picture < ApplicationRecord
  belongs_to :user

has_attached_file :pic_img, styles: { pic_index: "250x350>", pic_show: "325x475>" }, default_url: "/images/:style/missing.png"
validates_attachment_content_type :pic_img, content_type: /\Aimage\/.*\z/
end
