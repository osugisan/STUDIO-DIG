require "rails_helper"

RSpec.describe "ログイン", type: :request do
  let!(:user) { create(:user) }

  before do
    get new_user_session_path
  end

  it "正常なレスポンスを返すこと" do
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end

  it "有効なユーザーでログインできること" do
    sign_in user
    expect(response).to have_http_status(200)
  end

  it "無効なユーザーでログインできないこと" do
    post user_session_path, params: { session: { email: "", password: "" } }
    expect(response).to render_template('sessions/new')
  end

end