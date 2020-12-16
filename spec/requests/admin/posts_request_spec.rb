require 'rails_helper'

RSpec.describe 'Admin::Posts', type: :request do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin_user) }

  describe '#index' do
    context 'ログインしている場合' do
      it '管理ユーザーなら正常にアクセスできること' do
        sign_in admin_user
        get admin_posts_path
        expect(response.status).to eq 200
      end
      it '管理ユーザー以外なら投稿一覧ページにリダイレクトされること' do
        sign_in user
        get admin_posts_path
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get admin_posts_path
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end
end
