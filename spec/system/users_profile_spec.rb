require 'rails_helper'

RSpec.describe 'Users_Profile', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザープロフィールが正しく表示されること' do
    valid_login(user)

    find('.nav-icon').click
    find('.users-show').click

    expect(current_path).to eq user_path(user)
    expect(page).to have_content user.username
    expect(page).to have_content user.profile
  end
end
