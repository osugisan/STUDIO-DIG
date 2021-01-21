require "rails_helper"

RSpec.describe "ログアウト", type: :request do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }

  context "管理者ユーザーの場合" do
    it "ユーザーアカウントを削除できること" do
      sign_in admin_user
      expect { delete user_path(user) }.to change(User, :count).by(-1)
      expect(response).to redirect_to root_url
    end
  end

  context "管理者以外のユーザーの場合" do
    it "自分のアカウントを削除できること" do
      sign_in user
      expect { delete user_path(user) }.to change(User, :count).by(-1)
      expect(response).to redirect_to root_url
    end
    it "自分以外のアカウントを削除できないこと" do
      sign_in user
      expect { delete user_path(other_user) }.not_to change(User, :count)
      expect(response).to redirect_to user_url(other_user)
    end
  end

  context "ログインしていない場合" do
    it "ユーザーアカウントを削除しようとすると、トップページにリダイレクトされること" do
      expect { delete user_path(other_user) }.not_to change(User, :count)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_url
    end
  end
end