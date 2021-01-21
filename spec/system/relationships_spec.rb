require 'rails_helper'

RSpec.describe "relationships", type: :system do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  describe "メンバー一覧ページ" do
    before do
      create(:relationship, following_id: user.id, follower_id: user2.id)
      login(user)
      visit users_path
    end

    it "フォロー中のユーザーにフォローロゴが表示されること" do
      expect(page).to have_css ".follow-logo-image"
    end
  end

  describe "ユーザー詳細ページ" do
    before do
      create(:relationship, following_id: user.id, follower_id: user2.id)
      login(user)
    end

    context "フォローしている場合" do
      it "フォロー済みボタンが表示されること" do
        visit user_path(user2)
        expect(page).to have_content "フォロー済み"
      end
    end

    context "フォローしていない場合" do
      it "フォローするボタンが表示されること" do
        visit user_path(user3)
        expect(page).to have_content "フォローする"
      end
    end
  end

  describe "フォロー一覧ページ" do
    before do
      create(:relationship, following_id: user.id, follower_id: user2.id)
      login(user)
      visit follows_user_path(user)
    end

    it "フォロー中のユーザーが表示されること" do
      expect(page).to have_link user2.name
    end
  end

  describe "フォロワー一覧ページ" do
    before do
      create(:relationship, following_id: user2.id, follower_id: user.id)
      login(user)
      visit followers_user_path(user)
    end

    it "フォローされているユーザーが表示されること" do
      expect(page).to have_link user2.name
    end
  end

end