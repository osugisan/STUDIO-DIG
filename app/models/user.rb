class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :studios
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image

  validates :name, presence: true, length: { maximum: 50 }

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  def me?(user_id)
    id == user_id
  end
  
  def admin_or_me?(user_id)
    admin? || me?(user_id)
  end
end
