require "rails_helper"

RSpec.describe "レビュー機能", type: :request do
  let!(:user) { create(:user) }
  let!(:studio) { create(:studio) }
  let!(:review) { create(:review, user: user, studio: studio) }

  describe "レビューの登録" do
    context "ログインしている場合" do

      it "有効な情報で、レビュー登録ができること" do
        sign_in user
        expect {
          post studio_reviews_path(studio), params: { review: {
            rank: 5,
            title: Faker::Lorem.characters(number:10),
            body: Faker::Lorem.characters(number:20)
          }}
        }.to change(studio.reviews, :count).by(1)
      end
      it "無効な情報で、レビュー登録ができないこと" do
        sign_in user
        expect {
          post studio_reviews_path(studio), params: { review: {
            rank: "",
            title: Faker::Lorem.characters(number:10),
            body: Faker::Lorem.characters(number:20)
          }}
        }.not_to change(studio.reviews, :count)
      end
    end

    # context "ログインしていない場合" do
    #   post "/studios/#{studio.id}/reviews"
    #   expect(response).to redirect_to new_user_session_path
    # end
  end

  describe "レビューの削除" do
    context "ログインしている場合" do
      it "レビュー削除ができること" do
        sign_in user
        post studio_reviews_path(studio), params: { review: {
          rank: 5,
          title: Faker::Lorem.characters(number:10),
          body: Faker::Lorem.characters(number:20)
        }}
        expect {
          delete "/studios/#{studio.id}/reviews/#{review.id}"
        }.to change(studio.reviews, :count).by(-1)
      end
    end
  end
end