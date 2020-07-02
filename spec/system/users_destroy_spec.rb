require 'rails_helper'

RSpec.describe 'Users_Destroy', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザーが削除できること' do
    pending
    valid_login(user)
    visit root_path

    click_link 'ユーザーを削除'

    expect(current_path).to user_path(user)
    expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
  end
end
