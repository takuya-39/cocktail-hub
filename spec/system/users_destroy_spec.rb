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

    expect(current_path).to eq root_path
  end

  context 'ゲストユーザー' do
    it 'ゲストユーザーを削除しようとするとホーム画面にリダイレクトされること' do
      valid_guest_login(user)
      visit root_path

      find('.nav-icon-btn').click
      find('.users-show').click

      click_link 'ユーザーを削除'

      expect(current_path).to eq root_path
    end
  end
end
