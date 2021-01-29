require "rails_helper"

RSpec.describe "user関連リクエスト", type: :request do
  let!(:user) { create(:user) }

  context "一覧ページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get users_path
      expect(response).to render_template('users/index')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get users_path
      expect(response).to redirect_to new_user_session_url
    end
  end

  context "詳細ページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get user_path(user)
      expect(response).to render_template('users/show')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get user_path(user)
      expect(response).to redirect_to new_user_session_url
    end
  end

  context "お気に入りスタジオページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get favorites_user_path(user)
      expect(response).to render_template('users/favorites')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get favorites_user_path(user)
      expect(response).to redirect_to new_user_session_url
    end
  end
  
  context "フォロー一覧ページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get follows_user_path(user)
      expect(response).to render_template('users/follows')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get follows_user_path(user)
      expect(response).to redirect_to new_user_session_url
    end
  end
  
  context "フォロワー一覧ページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get followers_user_path(user)
      expect(response).to render_template('users/followers')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get followers_user_path(user)
      expect(response).to redirect_to new_user_session_url
    end
  end
  
  context "編集ページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get edit_user_path(user)
      expect(response).to render_template('users/edit')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get edit_user_path(user)
      expect(response).to redirect_to new_user_session_url
    end
  end

  context "投稿者のレビュー一覧ページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get reviews_user_path(user)
      expect(response).to render_template('users/reviews')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get reviews_user_path(user)
      expect(response).to redirect_to new_user_session_url
    end
  end

  context "投稿者のスタジオ一覧ページ" do
    it "ログインしている場合、レスポンスが正常に表示されること" do
      sign_in user
      get studios_user_path(user)
      expect(response).to render_template('users/studios')
    end
    it "ログインしていない場合、サインインページへリダイレクトされること" do
      get studios_user_path(user)
      expect(response).to redirect_to new_user_session_url
    end
  end
  
end
