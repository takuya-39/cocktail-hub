require 'rails_helper'

RSpec.describe 'PostsShow', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment, post_id: post.id) }

  context 'ログインしている場合' do
    it 'ログイン時用の投稿詳細ページが正しく表示されること' do
      valid_login(user)
      expect(current_path).to eq user_path(user)

      find('.nav-icon-btn').click
      find('.go-root').click
      expect(current_path).to eq root_path

      find(".post-#{ post.id }").click
      expect(current_path).to eq "/posts/#{ post.id }"
      expect(page).to have_content '投稿詳細'
      expect(page).to have_content post.title
      expect(page).to have_content post.genre
      expect(page).to have_selector "img[src$='user_a_post_image.jpg']"
      expect(page).to have_content '・テキーラ 50ml'
      expect(page).to have_content 'テキーラとカシスを混ぜてジンジャーエールで割ります'
      expect(page).to have_selector "img[src$='user_a_image.jpg']"
      expect(page).to have_content post.user.username
      expect(page).to have_content '投稿作成日時'
      expect(page).to have_content post.likes.count
      expect(page).to have_button 'コメントする'
      expect(page).not_to have_link 'ログインしてコメントする'
      expect(page).to have_content '作ってみようかな！'
    end
  end

  context 'ログインしていない場合' do
    it '非ログイン時用の投稿詳細ページが正しく表示されること' do
      visit root_path
      find(".post-#{ post.id }").click
      expect(current_path).to eq "/posts/#{ post.id }"
      expect(page).to have_content '投稿詳細'
      expect(page).to have_content post.title
      expect(page).to have_content post.genre
      expect(page).to have_selector "img[src$='user_a_post_image.jpg']"
      expect(page).to have_content '・テキーラ 50ml'
      expect(page).to have_content 'テキーラとカシスを混ぜてジンジャーエールで割ります'
      expect(page).to have_selector "img[src$='user_a_image.jpg']"
      expect(page).to have_content post.user.username
      expect(page).to have_content '投稿作成日時'
      expect(page).to have_content post.likes.count
      expect(page).to have_link 'ログインしてコメントする'
      expect(page).not_to have_button 'コメントする'
      expect(page).to have_content '作ってみようかな！'
    end
  end
end
