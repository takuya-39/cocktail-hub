require 'rails_helper'

RSpec.describe 'Users_Profile', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザープロフィールが正しく表示されること' do
    # ユーザーのプロフィール画面を確認する
    valid_login(user)

    visit root_path
    find('.nav-icon').click
    find('.users-show').click

    expect(current_path).to eq user_path(user)
    expect(page).to have_content user.username
    expect(page).to have_content user.profile

    # ユーザーのフォロー画面を確認する
    visit root_path
    find('.nav-icon').click
    find('.users-show').click
    expect(current_path).to eq "/users/#{ user.id }"

    click_link 'フォロー'
    expect(current_path).to eq "/users/#{ user.id }/followings"

    # ユーザーのフォロワー画面を確認する
    visit root_path
    find('.nav-icon').click
    find('.users-show').click
    expect(current_path).to eq "/users/#{ user.id }"

    click_link 'フォロワー'
    expect(current_path).to eq "/users/#{ user.id }/followers"
  end
end
