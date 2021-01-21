require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:favorite) { create(:favorite) }

  context "バリデーションのテスト" do
    it "favoriteインスタンスが有効であること" do
      expect(favorite).to be_valid
    end
    it "user_idがnilの場合、無効であること" do
      favorite.user_id = nil
      expect(favorite).to be_invalid
    end
    it "studio_idがnilの場合、無効であること" do
      favorite.studio_id = nil
      expect(favorite).to be_invalid
    end
  end
end