require "rails_helper"

RSpec.describe "お気に入り機能", type: :request do
  let!(:user) { create(:user) }
  let!(:studio) { create(:studio) }
  
  describe "お気に入り登録処理" do
    context "ログインしていない場合" do
      it "登録できずに、ログインページへリダイレクトされること" do
        post "/studios/#{studio.id}/favorites"
        expect(response).to redirect_to new_user_session_path
      end
      it "解除できずに、ログインページへリダイレクトされること" do
        delete "/studios/#{studio.id}/favorites"
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    context "ログインしている場合" do
      before do
        sign_in user
      end
      
      it "非同期にお気に入り登録ができること" do
        expect { 
          post "/studios/#{studio.id}/favorites", xhr: true
        }.to change(user.favorites, :count).by(1)
      end
      it "非同期にお気に入り解除ができること" do
        post "/studios/#{studio.id}/favorites", xhr: true
        expect { 
          delete "/studios/#{studio.id}/favorites", xhr: true
        }.to change(user.favorites, :count).by(-1)
      end
    end
  end
end