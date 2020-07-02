require 'rails_helper'

RSpec.describe 'Logout', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザーがログアウトできること' do
    valid_login(user)

    expect(current_path).to eq root_path
    expect(page).to have_content 'ログインしました'

    find('.nav-icon').click
    find('.logout').click

    expect(current_path).to eq root_path
    expect(page).to have_content 'ログアウトしました'
  end

  context 'ゲストユーザー' do
    it 'ゲストユーザーがログアウトできること' do
      valid_guest_login(user)

      expect(current_path).to eq root_path
      expect(page).to have_content 'ゲストユーザーとしてログインしました'

      find('.nav-icon').click
      find('.logout').click

      expect(current_path).to eq root_path
      expect(page).to have_content 'ログアウトしました'
    end
  end
end
