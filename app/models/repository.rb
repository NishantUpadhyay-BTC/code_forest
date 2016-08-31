class Repository < ApplicationRecord
  has_many :languages
    has_attached_file :poc_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/public/:style/missing.png"
end