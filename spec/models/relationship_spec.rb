require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:relationship) { create(:relationship) }

  context "バリデーションのテスト" do
    it "関係性が有効であること" do
      expect(relationship).to be_valid
    end
    it "following_idが空白の場合、関係性が無効であること" do
      relationship.following_id = nil
      expect(relationship).to be_invalid
    end
    it "follower_idが空白の場合、関係性が無効であること" do
      relationship.follower_id = nil
      expect(relationship).to be_invalid
    end
  end
end