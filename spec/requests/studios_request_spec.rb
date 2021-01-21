require "rails_helper"

RSpec.describe "studio関連リクエスト", type: :request do
  let!(:studio) { create(:studio) }

  context "一覧ページ" do
    it "レスポンスが正常に表示されること" do
      get studios_path
      expect(response).to render_template('studios/index')
    end
  end

  context "詳細ページ" do
    it "レスポンスが正常に表示されること" do
      get studio_path(studio)
      expect(response).to render_template('studios/show')
    end
  end

  context "ランキングページ" do
    it "レスポンスが正常に表示されること" do
      get ranks_studios_path
      expect(response).to render_template('studios/ranks')
    end
  end

  context "検索結果ページ" do
    it "レスポンスが正常に表示されること" do
      get searches_studios_path
      expect(response).to render_template('studios/searches')
    end
  end

  context "現在地検索ページ" do
    it "レスポンスが正常に表示されること" do
      get maps_studios_path
      expect(response).to render_template('studios/maps')
    end
  end
end