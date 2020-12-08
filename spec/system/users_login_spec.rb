require 'rails_helper'

RSpec.describe 'Login', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:guest_user) { create(:user, :guest_user) }

  it 'ユーザーがログインできること' do
    valid_login(user)
    expect(current_path).to eq user_path(user)
    expect(page).to have_content 'takuya'
  end

  it '無効な情報ではログインに失敗すること' do
    visit root_path
    find('.nav-icon-btn').click
    find('.login').click
    expect(current_path).to eq login_path

    perform_enqueued_jobs do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'ログインする'
    end
    expect(current_path).to eq new_user_session_path
  end

  context 'ゲストユーザーの場合' do
    it 'ゲストユーザーがログインできること' do
      valid_guest_login(guest_user)
      expect(current_path).to eq user_path(guest_user)
      expect(page).to have_content 'ゲストユーザー'
    end
  end
end
