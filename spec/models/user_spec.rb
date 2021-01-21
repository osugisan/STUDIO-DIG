require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }
    context 'nmaeカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        user.name = ""
        is_expected.to eq false;
      end
      it '２文字以上であること' do
        user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以内であること' do
        user.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
    end

    context 'introductionカラム' do
      let(:test_user) { user }
      it '50文字以下であること' do
        user.introduction = Faker::Lorem.characters(number:51)
        is_expected.to eq false;
      end
    end
  end
end