require 'rails_helper'

RSpec.describe 'Logout', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザーがログアウトできること' do
    valid_login(user)

    expect(current_path).to eq user_path(user)

    find('.nav-icon-btn').click
    find('.logout').click

    expect(current_path).to eq login_path
  end

  context 'ゲストユーザー' do
    it 'ゲストユーザーがログアウトできること' do
      valid_guest_login(user)

      expect(page).to have_content 'ゲストユーザー'

      find('.nav-icon-btn').click
      find('.logout').click

      expect(current_path).to eq login_path
    end
  end
end
