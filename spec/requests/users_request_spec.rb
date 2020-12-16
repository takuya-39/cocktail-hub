require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin_user) }

  describe '#show' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        get user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#user_show_posts' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        get user_show_posts_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get user_show_posts_user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#like_posts' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        get like_posts_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get like_posts_user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#followings' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        get followings_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get followings_user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#followers' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        get followers_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get followers_user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end
end
