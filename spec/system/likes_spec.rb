require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let!(:other_post) { create(:post, user: other_user) }

  it 'いいね、いいね解除ができること' do
    # userがログインする
    valid_login(user)
    expect(current_path).to eq "/users/#{ user.id }"

    # 投稿詳細ページに移動する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ other_post.id }").click
    expect(current_path).to eq "/posts/#{ other_post.id }"

    # 投稿にいいねをする
    expect do
      click_link 'like-btn'
      expect(page).to have_content '1'
    end.to change(other_post.likes, :count).by(1)

    # いいねを解除する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ other_post.id }").click
    expect(current_path).to eq "/posts/#{ other_post.id }"

    expect do
      click_link 'unlike-btn'
      expect(page).to have_content '0'
    end.to change(other_post.likes, :count).by(-1)
  end
end
