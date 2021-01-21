class Studio < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user, optional: true
  has_many :studio_tags, dependent: :destroy
  has_many :tags, through: :studio_tags
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  attachment :studio_image

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :address, presence: true, uniqueness: true
  validates :url, uniqueness: true, allow_blank: true
  validates :explanation, length: { maximum: 200 }
  validates :user_id, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
    return all if search.blank?

    where(['name LIKE ? OR address LIKE ?', "%#{search}%", "%#{search}%"])
  end
end
