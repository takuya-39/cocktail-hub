require 'rails_helper'

RSpec.describe 'ApiUsers', type: :request do
  describe '#index' do
    let(:user) { create(:user, username: 'APIユーザー') }

    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        get api_v1_users_path
        expect(response.status).to eq 200
      end
      it '特定のユーザーを取得できること' do
        get api_v1_users_path
        expect(response.status).to eq(200)
        expect(response.body).to include 'APIユーザー'
      end
    end
    context 'ログインしていない場合' do
      it 'nullが返されること' do
        get api_v1_users_path
        expect(response.status).to eq 200
        expect(response.body).to include 'null'
      end
    end
  end
end
