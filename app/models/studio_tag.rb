class StudioTag < ApplicationRecord
  belongs_to :studio
  belongs_to :tag

  validates :studio_id, presence: true
  validates :tag_id, presence: true
end
