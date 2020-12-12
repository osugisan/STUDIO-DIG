class Studio < ApplicationRecord

  belongs_to :user, optional: true
  has_many :studio_tags, dependent: :destroy
  has_many :tags, through: :studio_tags
  has_many :favorites, dependent: :destroy
  attachment :studio_image

  accepts_nested_attributes_for :tags

  validates :name, presence: true
  validates :address, presence: true
end
