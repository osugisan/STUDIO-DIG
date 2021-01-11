require 'rails_helper'

RSpec.describe Studio, type: :model do
  let!(:studio) { create(:studio) }

  context "バリデーションのテスト" do
    it "有効な状態であること" do
      expect(studio).to be_valid
    end
    it "スタジオ名がなければ無効な状態であること" do
      studio = build(:studio, name: nil)
      studio.valid?
      expect(studio.errors[:name]).to include("を入力してください")
    end
    it "住所がなければ無効な状態であること" do
      studio = build(:studio, address: nil)
      studio.valid?
      expect(studio.errors[:address]).to include("を入力してください")
    end
    it "スタジオ名が30文字以内であること" do
      studio.name = Faker::Lorem.characters(number:31)
      expect(studio).to be_invalid
    end
    it "おすすめポイントが200文字以内であること" do
      studio.explanation = Faker::Lorem.characters(number:201)
      expect(studio).to be_invalid
    end
    it "ユーザーIDがなければ無効な状態であること" do
      studio = build(:studio, user_id: nil)
      expect(studio).to be_invalid
    end
  end

end