class Studio < ApplicationRecord

  belongs_to :user
  attachment :studio_image

  validates :name, presence: true
  validates :address, presence: true
end
