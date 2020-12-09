require 'rails_helper'

RSpec.describe 'UsersProfile', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let!(:other_post) { create(:post, user: other_user) }
  let!(:relationship) { create(:relationship, follow_id: other_user.id, user_id: user.id) }

  it 'マイプロフィールが正しく表示されること' do
    # ユーザーのマイプロフィール画面を確認する
    valid_login(user)
    expect(current_path).to eq user_path(user)
    expect(page).to have_content user.username
    expect(page).to have_content user.profile
    expect(page).to have_selector '#followings', text: 1
    expect(page).to have_selector '#followers', text: 0
    expect(page).to have_link 'ユーザーを編集'
    expect(page).to have_link 'ユーザーを削除'

    # ユーザーのフォロー画面を確認する
    click_link 'フォロー'
    expect(current_path).to eq "/users/#{ user.id }/followings"

    # ユーザーのフォロワー画面を確認する
    find('.nav-icon-btn').click
    find('.users-show').click
    expect(current_path).to eq "/users/#{ user.id }"

    click_link 'フォロワー'
    expect(current_path).to eq "/users/#{ user.id }/followers"
  end

  context '別のユーザーのマイプロフィールにアクセスした場合' do
    it '編集、削除ボタンが表示されずにフォローボタンが表示されること' do
      valid_login(user)
      expect(current_path).to eq user_path(user)

      find('.nav-icon-btn').click
      find('.go-root').click
      expect(current_path).to eq root_path

      find(".post-#{ other_post.id }").click
      expect(current_path).to eq "/posts/#{ other_post.id }"
      find('.post-user').click
      expect(current_path).to eq "/users/#{ other_user.id }"
      expect(page).to have_content other_user.username
      expect(page).to have_content other_user.profile
      expect(page).to have_selector '#followings', text: other_user.followings.count
      expect(page).to have_selector '#followers', text: other_user.followers.count
      expect(page).to have_selector "#follow-form-#{ other_user.id }"
      expect(page).not_to have_link 'ユーザーを編集'
      expect(page).not_to have_link 'ユーザーを削除'
    end
  end
end
