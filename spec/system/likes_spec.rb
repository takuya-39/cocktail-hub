require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let!(:post) { create(:post, user: user) }

  it 'いいね機能' do
    # other_userがログインする
    valid_login(other_user)
    expect(current_path).to eq "/users/#{ other_user.id }"

    # 投稿詳細ページに移動する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ post.id }").click
    expect(current_path).to eq "/posts/#{ post.id }"

    # 投稿にいいねをする
    expect do
      click_link 'like-btn'
      expect(page).to have_content '1'
    end.to change(post.likes, :count).by(1)

    # いいねを解除する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ post.id }").click
    expect(current_path).to eq "/posts/#{ post.id }"

    expect do
      click_link 'unlike-btn'
      expect(page).to have_content '0'
    end.to change(post.likes, :count).by(-1)
  end
end
