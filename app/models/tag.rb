class Tag < ApplicationRecord
  has_many :studio_tags, dependent: :destroy
  has_many :tags, through: :studio_tags
end
