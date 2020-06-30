require 'rails_helper'

RSpec.describe 'Users_Profile', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.build(:user) }

  it 'ユーザープロフィールが正しく表示されること' do
    pending
    valid_login(user)

    expect(current_path).to user_path(user)
    expect(page).to have_content user.username
    expect(page).to have_content user.profile
  end
end
