require 'rails_helper'

RSpec.describe 'DeviseUsers', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, username: '') }
  let(:update_user_params) { attributes_for(:user, username: 'アップデートユーザー') }

  describe '#new' do
    it '正常にアクセスできること' do
      get signup_path
      expect(response).to have_http_status(:success)
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    context '正常なパラメータの場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end
      it 'ユーザーの作成が成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end
    end
    context '不正なパラメータな場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end
      it 'ユーザーの作成が失敗すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'ユーザーネームを入力してください'
      end
    end
  end

  describe '#edit' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        get edit_user_registration_path(user)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'エラーが表示されること' do
        get edit_user_registration_path(user)
        expect(response.body).to include 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe '#update' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      context '正常なパラメータの場合' do
        it 'リクエストが成功すること' do
          patch user_registration_path, params: { user: update_user_params }
          expect(response.status).to eq 200
        end
        it 'ユーザーの更新が成功すること' do
          patch user_registration_path, params: { user: update_user_params }
          expect(response.body).to include 'アップデートユーザー'
        end
      end
      context '不正なパラメータな場合' do
        it 'リクエストが成功すること' do
          patch user_registration_path, params: { user: invalid_user_params }
          expect(response.status).to eq 200
        end
        it 'ユーザーの更新が失敗すること' do
          patch user_registration_path, params: { user: invalid_user_params }
          expect(response.body).not_to include 'アップデートユーザー'
          expect(response.body).to include 'ユーザーネームを入力してください'
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        patch user_registration_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      context '正常なパラメータの場合' do
        it 'リクエストが成功すること' do
          delete user_registration_path
          expect(response.status).to eq 302
        end
        it 'ユーザーの削除が成功すること' do
          expect { delete user_registration_path }.to change { User.count }.by(-1)
          expect(response).to redirect_to login_path
        end
      end
    end
    context 'ログインしていない場合' do
      it 'エラーが表示されること' do
        delete user_registration_path(user)
        expect(response.body).to include 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end
