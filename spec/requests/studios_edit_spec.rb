require "rails_helper"

RSpec.describe "スタジオ編集", type: :request do
  let!(:user) { create(:user) }
  let!(:studio) { create(:studio) }

  context "ログインしている場合" do
    before do
      sign_in user
      get edit_studio_path(studio)
    end

    it "レスポンスが正常に表示されること" do
      expect(response).to render_template('studios/edit')
    end

    it "有効な情報でスタジオが編集できること" do
      patch studio_path(studio), params: { studio: {
        name: Faker::Lorem.characters(number:10),
        address: Faker::Lorem.characters(number:10),
        explanation: Faker::Lorem.characters(number:30),
        url: Faker::Internet.unique.url
      }}
      expect(response).to redirect_to studio_path(studio)
    end
    it "無効な情報でスタジオが編集できないこと" do
      expect {
        patch studio_path(studio), params: { studio: {
          name: "",
          address: Faker::Lorem.characters(number:10),
          explanation: Faker::Lorem.characters(number:30),
          url: Faker::Internet.unique.url
        }}
      }.not_to change(Studio, :count)
    end
  end

  context "ログインしていない場合" do
    it "ログイン画面にリダイレクトされること" do
      get edit_studio_path(studio)
      expect(response).to redirect_to new_user_session_path
    end
  end
end