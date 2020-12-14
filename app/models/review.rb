class Review < ApplicationRecord
  belongs_to :user
  belongs_to :studio

  validates :rank, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
