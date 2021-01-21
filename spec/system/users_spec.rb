require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:studio) { create(:studio, user: user) }
  let!(:review) { create(:review, user: user, studio: studio)}

  describe "ユーザー新規登録ページ" do
    before do
      visit new_user_registration_path
    end

    context "ページレイアウト" do
      it "「お気に入りのスタジオを見つけよう」の文字列が存在するかの確認" do
        expect(page).to have_content 'お気に入りのスタジオを見つけよう'
      end
    end

    context "ユーザー登録処理" do
      it "新規登録に成功する" do
        fill_in 'user[name]', with: Faker::Name.name
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録する'
        expect(page).to have_content '完了しました'
      end
      it "新規登録に失敗する" do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '登録する'
        expect(page).to have_content 'を入力してください'
      end
    end
  end

  describe 'ユーザーログイン' do
    before do
      visit new_user_session_path
    end

    context "ページレイアウト" do
      it "かんたんログインボタンが表示される" do
        expect(page).to have_button '採用担当者様はこちらへ'
      end
    end

    context "ユーザーログイン処理" do
      it "ログインに成功する" do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'サインインする'
        expect(page).to have_content "ログインしました"
      end
      it "ログインに失敗する" do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'サインインする'
        expect(page).to have_content "パスワードが違います"
      end
    end
  end

  describe "マイページ" do
    before do
      login(user)
      create_list(:studio, 5, user: user)
      create_list(:review, 5, user: user, studio: studio)
      visit user_path(user)
    end

    context "ページレイアウト" do
      it "「P　R　O　F　I　L　E」の文字が表示されること" do
        expect(page).to have_content "P　R　O　F　I　L　E"
      end
      it "自分以外のユーザーに編集ボタンが表示されないこと" do
        visit user_path(other_user)
        expect(page).not_to have_link "P R O F I L E　E D I T"
      end
      it "スタジオ情報が表示されていること" do
        Studio.take(5).each do |studio|
          expect(page).to have_link studio.name
          expect(page).to have_content studio.address
        end
      end
      it "レビュー情報が表示されていること" do
        Review.take(5).each do |review|
          expect(page).to have_content review.title
          expect(page).to have_content review.body
        end
      end
    end

  end

  describe "ユーザー編集ページ" do
    before do
      login(user)
      visit edit_user_path(user)
    end

    context "ページレイアウト" do
      it "自分の編集ページに退会ボタンが存在すること" do
        expect(page).to have_link "退会する"
      end
    end
  end

  describe "ユーザー一覧ページ" do
    before do
      login(user)
      create_list(:user, 6)
      visit users_path
    end
    context "ページレイアウト" do
      it "M E M B E R Sの文字が表示されること" do
        expect(page).to have_content "M E M B E R S"
      end
      it "ページネーションが表示されること" do
        expect(page).to have_css ".pagination"
      end
    end
  end

end