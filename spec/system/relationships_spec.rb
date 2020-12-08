require 'rails_helper'

RSpec.describe 'Relationships', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let!(:post) { create(:post, user: user) }

  it 'フォロー、フォロー解除ができること' do
    pending
    # other_userがuserをフォローする
    valid_login(other_user)
    expect(current_path).to eq "/users/#{ other_user.id }"

    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ post.id }").click
    expect(current_path).to eq "/posts/#{ post.id }"
    find('.post-user').click
    expect(current_path).to eq "/users/#{ user.id }"

    expect do
      click_button 'フォローする'
      expect(page).to have_button 'フォロー中'
      expect(page).to have_selector '#unfollow'
    end.to change(user.followers, :count).by(1) &
           change(other_user.followings, :count).by(1)

    # other_userのフォローページにuserが追加されている
    find('.nav-icon-btn').click
    find('.users-show').click
    expect(current_path).to eq user_path(other_user)
    expect(page).to have_content other_user.username
    expect(page).to have_content other_user.profile

    click_link 'フォロー'
    expect(current_path).to eq followings_user_path(other_user)
    expect(page).to have_content user.username
    expect(page).to have_button 'フォロー中'

    # other_userがuserへのフォローを解除する
    visit user_path(user)
    expect(current_path).to eq "/users/#{ user.id }"

    expect do
      click_button 'フォロー中'
      expect(page).to have_button 'フォローする'
      expect(page).to have_selector '#follow'
    end.to change(user.followers, :count).by(-1) &
           change(other_user.followings, :count).by(-1)

    # other_userのフォローページからuserが削除されている
    find('.nav-icon-btn').click
    find('.users-show').click
    expect(current_path).to eq user_path(other_user)
    expect(page).to have_content other_user.username
    expect(page).to have_content other_user.profile

    click_link 'フォロー'
    expect(current_path).to eq followings_user_path(other_user)
    expect(page).not_to have_content user.username
    expect(page).not_to have_button 'フォロー中'
  end
end
