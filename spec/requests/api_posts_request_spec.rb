require 'rails_helper'

RSpec.describe 'ApiPosts', type: :request do
  describe '#index' do
    it 'リクエストが成功すること' do
      get api_v1_posts_path
      expect(response.status).to eq 200
    end
    it '全ての投稿を取得できること' do
      create_list(:post, 10)
      get api_v1_posts_path
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.length).to eq(10)
    end
  end
end
