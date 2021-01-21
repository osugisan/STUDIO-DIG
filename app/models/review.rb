class Review < ApplicationRecord
  belongs_to :user
  belongs_to :studio
  has_many :likes, dependent: :destroy

  validates :rank, presence: true
  validates :title, presence: true, length: { maximum: 15 }
  validates :body, presence: true, length: { maximum: 60 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.average_rank(digits = 1)
    average(:rank).to_f.round(digits)
  end
end
