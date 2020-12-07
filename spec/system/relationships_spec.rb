require 'rails_helper'

RSpec.describe 'Relationships', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:otheruser) { create(:user, :otheruser) }
  let!(:post) { create(:post, user: user) }

  it 'フォロー機能' do
    # otheruserがuserをフォローする
    valid_login(otheruser)

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
           change(otheruser.followings, :count).by(1)

    # otheruserのフォローページにuserが追加されている
    find('.nav-icon-btn').click
    find('.users-show').click
    expect(current_path).to eq user_path(otheruser)
    expect(page).to have_content otheruser.username
    expect(page).to have_content otheruser.profile

    click_link 'フォロー'
    expect(current_path).to eq followings_user_path(otheruser)
    expect(page).to have_content user.username
    expect(page).to have_button 'フォロー中'

    # otheruserがuserへのフォローを解除する
    visit user_path(user)
    expect(current_path).to eq "/users/#{ user.id }"

    expect do
      click_button 'フォロー中'
      expect(page).to have_button 'フォローする'
      expect(page).to have_selector '#follow'
    end.to change(user.followers, :count).by(-1) &
           change(otheruser.followings, :count).by(-1)

    # otheruserのフォローページからuserが削除されている
    find('.nav-icon-btn').click
    find('.users-show').click
    expect(current_path).to eq user_path(otheruser)
    expect(page).to have_content otheruser.username
    expect(page).to have_content otheruser.profile

    click_link 'フォロー'
    expect(current_path).to eq followings_user_path(otheruser)
    expect(page).not_to have_content user.username
    expect(page).not_to have_button 'フォロー中'
  end
end
