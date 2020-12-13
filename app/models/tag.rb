class Tag < ApplicationRecord
  has_many :studio_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :tags, through: :studio_tags
end
