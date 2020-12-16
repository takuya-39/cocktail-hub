require 'rails_helper'

RSpec.describe 'UsersDestroy', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:admin_user) { create(:user, :admin_user) }
  let(:guest_user) { create(:user, :guest_user) }

  it 'ユーザーが削除できること' do
    user = create(:user, email: 'destroy@example.com')
    expect(User.where(email: 'destroy@example.com')).not_to be_empty

    valid_login(user)
    expect(current_path).to eq "/users/#{ user.id }"

    click_link 'ユーザーを削除'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'ログインページ'
    expect(current_path).to eq login_path
    expect(User.where(email: 'destroy@example.com')).to be_empty
  end

  context '管理ユーザーの場合' do
    it '管理ユーザーを削除しようとするとマイプロフィール画面にリダイレクトされること' do
      valid_login(admin_user)
      expect(page).to have_content 'ログインしました。'
      expect(current_path).to eq "/users/#{ admin_user.id }"

      click_link 'ユーザーを削除'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content '管理ユーザーの編集、削除はできません'
      expect(current_path).to eq "/users/#{ admin_user.id }"
    end
  end

  context 'ゲストユーザーの場合' do
    it 'ゲストユーザーを削除しようとするとマイプロフィール画面にリダイレクトされること' do
      valid_guest_login(guest_user)
      expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      expect(current_path).to eq "/users/#{ guest_user.id }"

      click_link 'ユーザーを削除'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'ゲストユーザーの編集、削除はできません'
      expect(current_path).to eq "/users/#{ guest_user.id }"
    end
  end
end
