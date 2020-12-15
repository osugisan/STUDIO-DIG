class Studio < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user, optional: true
  has_many :studio_tags, dependent: :destroy
  has_many :tags, through: :studio_tags
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  attachment :studio_image

  accepts_nested_attributes_for :tags

  validates :name, presence: true
  validates :address, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
