require 'rails_helper'

RSpec.describe "Studios", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:studio) { create(:studio, user: user) }
  let!(:other_studio) { create(:studio, user: user) }
  let!(:review) { create(:review, user: user, studio: studio) }

  describe "スタジオ新規投稿ページ" do
    before do
      login(user)
      visit new_studio_path
    end

    context "スタジオ新規登録処理" do
      it "スタジオ新規登録に成功すること" do
        fill_in 'studio[name]', with: Faker::Lorem.characters(number:10)
        fill_in 'studio[address]', with: Faker::Lorem.characters(number:10)
        fill_in 'studio[explanation]', with: Faker::Lorem.characters(number:30)
        fill_in 'studio[url]', with: Faker::Internet.unique.url
        click_button "登録する"
        expect(page).to have_content "保存されました"
      end
      it "スタジオ新規登録に失敗すること" do
        fill_in 'studio[name]', with: ""
        fill_in 'studio[address]', with: ""
        fill_in 'studio[explanation]', with: ""
        fill_in 'studio[url]', with: ""
        click_button "登録する"
        expect(page).to have_content "を入力してください"
      end
    end
  end

  describe "スタジオ詳細ページ" do

    context "ログイン前のページレイアウト" do
      it "お気に入り、いいね機能が表示されないこと" do
        visit studio_path(studio)
        expect(page).not_to have_css "fav-smallitem"
        expect(page).not_to have_css "like-smallitem"
      end
    end

    before do
      login(user)
      visit studio_path(studio)
    end

    context "ログイン後のページレイアウト" do
      it "全てのユーザーにスタジオ編集ボタンが表示されること" do
        expect(page).to have_link "スタジオ情報を編集する"
        visit studio_path(other_studio)
        expect(page).to have_link "スタジオ情報を編集する"
      end
      it "自分の投稿にスタジオ削除ボタンが表示されること" do
        expect(page).to have_link "スタジオを削除する"
      end
    end

    context "口コミ投稿処理" do
      it "口コミ投稿に成功すること" do
        fill_in 'review[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'review[body]', with: Faker::Lorem.characters(number:20)
        find('#review_star', visible: false).set(5)
        click_button "口コミを投稿"
        expect(page).to have_content "保存されました"
      end
      it "口コミ投稿に失敗すること" do
        fill_in 'review[title]', with: ""
        fill_in 'review[body]', with: ""
        find('#review_star', visible: false).set("")
        click_button "口コミを投稿"
        expect(page).to have_content "を入力してください"
      end
    end

    context "スタジオマップ" do
      it "正常にマップが表示されること" do
        expect find('#map', visible: false).text(:all)
      end
    end

  end

  describe "スタジオ編集ページ" do
    before do
      login(user)
      visit edit_studio_path(studio)
    end

    context "スタジオの更新処理" do
      it "更新に成功すること" do
        fill_in 'studio[name]', with: Faker::Lorem.characters(number:10)
        fill_in 'studio[address]', with: Faker::Lorem.characters(number:10)
        fill_in 'studio[explanation]', with: Faker::Lorem.characters(number:30)
        fill_in 'studio[url]', with: Faker::Internet.unique.url
        click_button "更新する"
        expect(page).to have_content "更新されました"
      end
      it "自分の投稿に削除ボタンが存在すること" do
        expect(page).to have_link "削除する"
      end
    end
  end

  describe "トップ画面" do
    before do
      visit root_path
    end

    context "ページレイアウト" do
      it "検索フォームが表示されること" do
        expect(page).to have_css "#search"
      end
    end
  end

  describe "スタジオ一覧ページ" do
    before do
      visit studios_path
    end

    context "ページレイアウト" do
      it "カードが正しく表示されていること" do
        expect(page).to have_css ".col-lg-4.col-12"
        expect(page).to have_css ".col-lg-11.col-10.mx-auto"
      end
    end
  end

  describe "現在地から探すページ" do
    before do
      visit maps_studios_path
    end
    
    it "マップが正常に表示されること" do
      expect find('#map', visible: false).text(:all)
    end
  end

  describe "ログイン前後で、表示の切り替え" do
    context "ログイン前の表示" do
      before do
        visit studios_path
      end

      it "ヘッダーのアイコンが正しく表示されること" do
        expect(page).to have_css ".fa-user-plus"
        expect(page).to have_css ".fa-sign-in-alt"
      end
      it "インフォメーションバーのアイテムが、正常に４つ表示されること" do
        expect(page).to have_link "", href: "/studios"
        expect(page).to have_link "", href: "/studios/ranks"
        expect(page).to have_link "", href: "/studios/new"
        expect(page).to have_link "", href: "/studios/maps"
      end
    end

    context "ログイン後の表示" do
      before do
        login(user)
        visit studios_path
      end

      it "ヘッダーのアイコンが正しく表示されること" do
        expect(page).to have_css ".fa-plus-square"
        expect(page).to have_css ".fa-user"
      end
      it "インフォメーションバーのアイテムが、正常に5つ表示されること" do
        expect(page).to have_link "", href: "/studios"
        expect(page).to have_link "", href: "/studios/ranks"
        expect(page).to have_css ".favorite-info"
        expect(page).to have_link "", href: "/studios/new"
        expect(page).to have_link "", href: "/studios/maps"
      end
    end
  end
end