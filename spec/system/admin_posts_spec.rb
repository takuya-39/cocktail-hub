require 'rails_helper'

RSpec.describe 'AdminPosts', type: :system, js: true do
  include ActiveJob::TestHelper
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin_user) }

  context '管理ユーザーの場合' do
    it '管理用投稿一覧画面にアクセスでき、投稿の削除ができること' do
      test_post = create(:post, title: 'テスト')
      valid_login(admin_user)
      expect(current_path).to eq "/users/#{ admin_user.id }"

      visit admin_posts_path
      expect(current_path).to eq admin_posts_path
      expect(page).to have_content 'テスト'

      # 投稿を削除する
      find("#post-delete-btn-#{ test_post.id }").click
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content 'テスト'
      expect(Post.where(title: 'テスト')).to be_empty
    end
  end

  context '管理ユーザー以外の場合' do
    it '管理用投稿一覧画面にアクセスできず、投稿一覧画面にリダイレクトされること' do
      valid_login(user)
      expect(current_path).to eq "/users/#{ user.id }"

      visit admin_posts_path
      expect(current_path).not_to eq admin_posts_path
      expect(current_path).to eq root_path
    end
  end
end
