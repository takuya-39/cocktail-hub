require 'rails_helper'

RSpec.describe 'Relationships', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let!(:other_post) { create(:post, user: other_user) }

  it 'フォロー、フォロー解除ができること' do
    # userがother_userをフォローする
    valid_login(user)
    expect(current_path).to eq "/users/#{ user.id }"

    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ other_post.id }").click
    expect(current_path).to eq "/posts/#{ other_post.id }"
    find('.post-user').click
    expect(current_path).to eq "/users/#{ other_user.id }"

    expect do
      click_button 'フォローする'
      expect(page).to have_button 'フォロー中'
      expect(page).to have_selector '#unfollow'
    end.to change(other_user.followers, :count).by(1) &
           change(user.followings, :count).by(1)

    # userのフォローページにother_userが追加されている
    find('.nav-icon-btn').click
    find('.users-show').click
    expect(current_path).to eq user_path(user)

    click_link 'フォロー'
    expect(current_path).to eq followings_user_path(user)
    expect(page).to have_content other_user.username
    expect(page).to have_button 'フォロー中'

    # userがother_userへのフォローを解除する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ other_post.id }").click
    expect(current_path).to eq "/posts/#{ other_post.id }"
    find('.post-user').click
    expect(current_path).to eq "/users/#{ other_user.id }"

    expect do
      click_button 'フォロー中'
      expect(page).to have_button 'フォローする'
      expect(page).to have_selector '#follow'
    end.to change(other_user.followers, :count).by(-1) &
           change(user.followings, :count).by(-1)

    # userのフォローページからother_userが削除されている
    find('.nav-icon-btn').click
    find('.users-show').click
    expect(current_path).to eq user_path(user)
    expect(page).to have_content user.username

    click_link 'フォロー'
    expect(current_path).to eq followings_user_path(user)
    expect(page).not_to have_content other_user.username
    expect(page).not_to have_button 'フォロー中'
  end
end
