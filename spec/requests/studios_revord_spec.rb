require "rails_helper"

RSpec.describe "スタジオ新規登録", type: :request do
  let!(:user) { create(:user) }
  let!(:studio) { create(:studio, user: user) }

  context "ログインしている場合" do
    before do
      sign_in user
      get new_studio_path
    end

    it "レスポンスが正常に表示されること" do
      expect(response).to render_template('studios/new')
    end

    it "有効な情報でスタジオが登録できること" do
      expect {
        post studios_path, params: { studio: {
          name: Faker::Lorem.characters(number:10),
          address: Faker::Lorem.characters(number:10),
          explanation: Faker::Lorem.characters(number:30),
          url: Faker::Internet.unique.url
        }}
      }.to change(Studio, :count).by(1)
    end
    it "無効な情報でスタジオが登録できないこと" do
        post studios_path, params: { studio: {
          name: "",
          address: Faker::Lorem.characters(number:10),
          explanation: Faker::Lorem.characters(number:30),
          url: Faker::Internet.unique.url
        }}
      expect(response).to render_template('studios/new')
    end
  end

  context "ログインしていない場合" do
    it "ログイン画面にリダイレクトされること" do
      get new_studio_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end