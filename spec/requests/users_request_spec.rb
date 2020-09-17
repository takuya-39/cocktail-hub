require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  describe 'show' do
    it '正常にアクセスできること' do
      pending
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end

  describe 'followings' do
    it '正常にアクセスできること' do
      pending
      get user_followings_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end

  describe 'followers' do
    it '正常にアクセスできること' do
      pending
      get user_followers_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end
end
