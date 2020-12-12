class Studio < ApplicationRecord

  belongs_to :user
  has_many :studio_tags, dependent: :destroy
  has_many :tags, through: :studio_tags
  attachment :studio_image

  validates :name, presence: true
  validates :address, presence: true
end
