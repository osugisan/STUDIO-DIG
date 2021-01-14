require "rails_helper"

RSpec.describe "ユーザー登録", type: :request do
  before do
    get new_user_registration_path
  end

  it "正常なレスポンスを返すこと" do
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end

  it "有効なユーザーで登録できること" do
    expect {
      post user_registration_path, params: { user: { name: Faker::Name.name,
                                                     email: Faker::Internet.email,
                                                     password: "password",
                                                     password_confirmation: "password" } }
    }.to change(User, :count).by(1)
  end

  it "無効なユーザーで登録できないこと" do
    expect {
      post user_registration_path, params: { user: { name: "",
                                                     email: Faker::Internet.email,
                                                     password: "password",
                                                     password_confirmation: "password" } }
    }.not_to change(User, :count)
    end

end