class User < ApplicationRecord
  has_many :pictures

  has_attached_file :avatar, styles: { ave_index: "300x300>", ave_show: "320x475>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         
end
