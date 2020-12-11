require 'rails_helper'

RSpec.describe 'ApiRankings', type: :request do
  describe '#index' do
    it 'リクエストが成功すること' do
      get api_v1_rankings_path
      expect(response.status).to eq 200
    end
    it '特定の投稿を取得できること' do
      create_list(:post, 10)
      get api_v1_rankings_path
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.length).to eq(3)
    end
  end
end
