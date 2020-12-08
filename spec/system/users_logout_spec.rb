require 'rails_helper'

RSpec.describe 'UsersLogout', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:guest_user) { create(:user, :guest_user) }

  it 'ユーザーがログアウトできること' do
    valid_login(user)
    find('.nav-icon-btn').click
    find('.logout').click
    expect(current_path).to eq login_path
  end

  context 'ゲストユーザーの場合' do
    it 'ゲストユーザーがログアウトできること' do
      valid_guest_login(guest_user)
      find('.nav-icon-btn').click
      find('.logout').click
      expect(current_path).to eq login_path
    end
  end
end
