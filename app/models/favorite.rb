class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :studio

  validates_uniqueness_of :studio_id, scope: :user_id
  # バリデーション（ユーザーとスタジオの組み合わせは一意）
end
