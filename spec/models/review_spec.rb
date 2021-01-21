require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:review) { create(:review) }

  context "バリデーションのテスト" do
    it "有効な状態であること" do
      expect(review).to be_valid
    end
    it "user_idがなければ無効な状態であること" do
      review = build(:review, user_id: nil)
      expect(review).to be_invalid
    end
    it "studio_idがなければ無効な状態であること" do
      review = build(:review, studio_id: nil)
      expect(review).to be_invalid
    end
    it "タイトルが空白であれば無効な状態であること" do
      review = build(:review, title: nil)
      expect(review).to be_invalid
    end
    it "本文が空白であれば無効な状態であること" do
      review = build(:review, body: nil)
      expect(review).to be_invalid
    end
    it "星評価が空白であれば無効な状態であること" do
      review = build(:review, rank: nil)
      expect(review).to be_invalid
    end
    it "タイトルが15文字以内であること" do
      review.title = Faker::Lorem.characters(number:16)
      expect(review).to be_invalid
    end
    it "本文が60文字以内であること" do
      review.body = Faker::Lorem.characters(number:61)
      expect(review).to be_invalid
    end
  end
end