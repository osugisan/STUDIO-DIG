require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:like) { create(:like) }

  context "バリデーションのテスト" do
    it "likeインスタンスが有効であること" do
      expect(like).to be_valid
    end
    it "user_idがnilの場合、無効であること" do
      like.user_id = nil
      expect(like).to be_invalid
    end
    it "review_idがnilの場合、無効であること" do
      like.review_id = nil
      expect(like).to be_invalid
    end
  end
end