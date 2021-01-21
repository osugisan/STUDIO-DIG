require "rails_helper"

RSpec.describe "ユーザー編集", type: :request do
  let!(:user) { create(:user) }

  it "ユーザー情報を正常に更新できること" do
    sign_in user
    patch user_path(user), params: { user: { name: Faker::Name.name,
                                       email: Faker::Internet.email,
                                       introduction: Faker::Lorem.characters(number: 20) } }
    expect(response).to redirect_to user_path(user)
  end
end