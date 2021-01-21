require "rails_helper"

RSpec.describe "フォロー機能", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  before do
    sign_in user
  end

  it "ユーザーのフォローができること" do
    expect {
      post relationships_path(user), params: { follower_id: other_user.id }
    }.to change(user.followings, :count).by(1)
  end
  it "ユーザーのアンフォローができること" do
    post relationships_path(user), params: { follower_id: other_user.id }
    expect { delete relationships_path(user) }.to change(user.followings, :count).by(-1)
  end
end