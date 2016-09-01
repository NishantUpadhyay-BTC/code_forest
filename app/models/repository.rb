class Repository < ApplicationRecord
  has_many :languages, inverse_of: :repository
    has_attached_file :poc_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/public/missing.png",
                      url: "/system/:id/:style/:filename"
    accepts_nested_attributes_for :languages
    validates_attachment_content_type :poc_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end