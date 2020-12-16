require 'rails_helper'

RSpec.describe 'AdminUsers', type: :system, js: true do
  include ActiveJob::TestHelper
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin_user) }
  let!(:guest_user) { create(:user, :guest_user) }

  context '管理ユーザーの場合' do
    it 'ユーザー一覧画面にアクセスでき、ユーザーの削除ができること' do
      test_user = create(:user, username: 'テストユーザー', email: 'test@example.com')
      valid_login(admin_user)
      expect(current_path).to eq "/users/#{ admin_user.id }"

      visit admin_users_path
      expect(current_path).to eq admin_users_path
      expect(page).to have_content test_user.username

      # 管理ユーザーとゲストユーザーはユーザー一覧に表示されない
      expect(page).not_to have_content admin_user.username
      expect(page).not_to have_content guest_user.username

      # ユーザーを削除する
      find("#user-delete-btn-#{ test_user.id }").click
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content test_user.username
      expect(User.where(email: 'test@example.com')).to be_empty
    end
  end

  context '管理ユーザー以外の場合' do
    it 'ユーザー一覧画面にアクセスできず、投稿一覧画面にリダイレクトされること' do
      valid_login(user)
      expect(current_path).to eq "/users/#{ user.id }"

      visit admin_users_path
      expect(current_path).not_to eq admin_users_path
      expect(current_path).to eq root_path
    end
  end
end
