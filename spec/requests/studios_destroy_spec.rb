require "rails_helper"

RSpec.describe "スタジオ削除", type: :request do
  let!(:user) { create(:user) }
  let!(:studio) { create(:studio) }

  context "ログインしている場合" do
    it "スタジオを削除できる" do
      sign_in user
      expect { delete studio_path(studio) }.to change(Studio, :count).by(-1)
      expect(response).to redirect_to studios_path
    end
  end

  context "ログインしていない場合" do
    it "スタジオを削除できず、ログインページにリダイレクトされる" do
      delete studio_path(studio)
      expect(response).to redirect_to new_user_session_path
    end
  end
end