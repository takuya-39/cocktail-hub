require 'rails_helper'

RSpec.describe 'Users_Profile', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザープロフィールが正しく表示されること' do
    pending
    valid_login(user)

    get '/users/:id'

    expect(current_path).to user_path(user)
    expect(page).to have_content user.username
    expect(page).to have_content user.profile
  end
end
