class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates_uniqueness_of :review_id, scope: :user_id
  # バリデーション（ユーザーとレビューの組み合わせは一意）
end
