require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let(:post_params) { attributes_for(:post) }
  let(:invalid_post_params) { attributes_for(:post, title: '') }
  let(:update_post_params) { attributes_for(:post, title: 'アップデートタイトル') }

  describe '#index' do
    it '正常にアクセスできること' do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.status).to eq 200
    end
  end

  describe '#show' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        post = create(:post, user: user)
        sign_in user
        get post_path(post)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post = create(:post)
        get post_path(post)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#new' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        get new_post_path
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get new_post_path
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      context '正常なパラメータの場合' do
        it 'リクエストが成功すること' do
          post posts_path, params: { post: post_params }
          expect(response.status).to eq 302
        end
        it '投稿の作成が成功すること' do
          expect do
            post posts_path, params: { post: post_params }
          end.to change(Post, :count).by 1
        end
      end
      context '不正なパラメータな場合' do
        it 'リクエストが成功すること' do
          post posts_path, params: { post: invalid_post_params }
          expect(response.status).to eq 200
        end
        it '投稿の作成が失敗すること' do
          post posts_path, params: { post: invalid_post_params }
          expect(response.body).to include 'タイトルを入力してください'
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post posts_path, params: { post: post_params }
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#edit' do
    context 'ログインしている場合' do
      it '正常にアクセスできること' do
        sign_in user
        post = create(:post, user: user)
        get edit_post_path(post)
        expect(response).to have_http_status(:success)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post = create(:post)
        get edit_post_path(post)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
    context '認可されていないユーザーがアクセスした場合' do
      it '投稿一覧ページにリダイレクトされること' do
        post = create(:post, user: user)
        sign_in other_user

        get edit_post_path(post)
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
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
          post = create(:post, user: user)
          patch post_path(post), params: { post: update_post_params }
          expect(response.status).to eq 302
        end
        it '投稿の更新が成功すること' do
          post = create(:post, user: user, title: 'サンプルタイトル')
          expect do
            patch post_path(post), params: { post: update_post_params }
          end.to change { Post.find(post.id).title }.from('サンプルタイトル').to('アップデートタイトル')
        end
      end
      context '不正なパラメータな場合' do
        it 'リクエストが成功すること' do
          post = create(:post, user: user)
          patch post_path(post), params: { post: invalid_post_params }
          expect(response.status).to eq 200
        end
        it '投稿の更新が失敗すること' do
          post = create(:post, user: user)
          patch post_path(post), params: { post: invalid_post_params }
          expect(response.body).to include 'タイトルを入力してください'
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post = create(:post)
        get post_path(post), params: { post: post_params }
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
    context '認可されていないユーザーがアクセスした場合' do
      it '投稿を更新できず、投稿一覧ページにリダイレクトされること' do
        post = create(:post, user: user)
        sign_in other_user
        patch post_path(post), params: { post: post_params }
        expect(response).to redirect_to root_url
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
          post = create(:post, user: user)
          delete post_path(post)
          expect(response.status).to eq 302
        end
        it '投稿の削除が成功すること' do
          post = create(:post, user: user)
          expect { delete post_path(post) }.to change { Post.count }.by(-1)
          expect(response).to redirect_to root_url
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post = create(:post)
        delete post_path(post)
        expect(response.status).to eq 302
        expect(response).to redirect_to login_path
      end
    end
    context '認可されていないユーザーがアクセスした場合' do
      it '投稿を削除できず、投稿一覧ページにリダイレクトされること' do
        post = create(:post, user: user)
        sign_in other_user
        expect { delete post_path(post) }.to change { Post.count }.by(0)
        expect(response).to redirect_to root_url
      end
    end
  end
end
