require 'rails_helper'

RSpec.describe 'Users_Destroy', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザーが削除できること' do
    valid_login(user)

    visit root_path
    find('.nav-icon-btn').click
    find('.users-show').click

    click_link 'ユーザーを削除'
    page.driver.browser.switch_to.alert.accept

    expect(current_path).to eq login_path
  end

  context 'ゲストユーザー' do
    it 'ゲストユーザーを削除しようとするとマイプロフィール画面にリダイレクトされること' do
      valid_guest_login(user)
      visit root_path

      find('.nav-icon-btn').click
      find('.users-show').click

      click_link 'ユーザーを削除'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_content 'ゲストユーザーの編集、削除はできません'
    end
  end
end
