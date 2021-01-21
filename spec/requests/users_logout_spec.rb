require "rails_helper"

RSpec.describe "ログアウト", type: :request do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  it "ログアウトができること" do
    delete destroy_user_session_path(user)
    expect(response).to have_http_status(204)
  end

end