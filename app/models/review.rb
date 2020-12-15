class Review < ApplicationRecord
  belongs_to :user
  belongs_to :studio
  has_many :likes, dependent: :destroy

  validates :rank, presence: true
  validates :title, presence: true
  validates :body, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
