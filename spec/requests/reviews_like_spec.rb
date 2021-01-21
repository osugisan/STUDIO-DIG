require "rails_helper"

RSpec.describe "いいね機能", type: :request do
  let!(:user) { create(:user) }
  let!(:studio) { create(:studio) }
  let!(:review) { create(:review, user: user, studio: studio) }

  describe "いいね登録処理" do
    context "ログインしていない場合" do
      it "登録できずに、ログインページへリダイレクトされること" do
        post "/studios/#{studio.id}/reviews/#{review.id}/likes"
        expect(response).to redirect_to new_user_session_path
      end
      it "解除できずに、ログインページへリダイレクトされること" do
        delete "/studios/#{studio.id}/reviews/#{review.id}/likes"
        expect(response).to redirect_to new_user_session_path
      end
    end

    # context "ログインしている場合" do
    #   before do
    #     sign_in user
    #   end

    #   it "いいね登録ができること" do
    #     expect {
    #       post "/studios/#{studio.id}/reviews/#{review.id}/likes"
    #     }.to change(review.likes, :count).by(1)
    #   end
    #   it "いいね解除ができること" do
    #     post "/studios/#{studio.id}/reviews/#{review.id}/likes"
    #     expect {
    #       delete "/studios/#{studio.id}/reviews/#{review.id}/likes"
    #     }.to change(review.likes, :count).by(-1)
    #   end
    # end
  end
end