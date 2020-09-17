require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'いいね機能' do
    # ログインする
    valid_login(user)

    visit root_path
    find('.posts-new').click
    expect(current_path).to eq new_post_path
    expect(page).to have_content '新規投稿'

    expect do
      fill_in 'Title', with: 'オリジナルカクテル'
      select 'ウイスキー', from: 'Genre'
      attach_file 'Image', "#{ Rails.root }/spec/support/assets/sample_post_image.jpg"
      fill_in 'Ingredients', with: '材料'
      fill_in 'Memo', with: '作り方メモ'
      click_button '投稿する'
    end.to change(Post, :count).by(1)

    post = Post.first

    # 投稿詳細ページに移動する
    click_link nil, href: "/posts/#{ post.id }"
    expect(current_path).to eq "/posts/#{ post.id }"

    # 投稿にいいねをする
    expect do
      click_link 'like-btn'
      expect(page).to have_content '1'
    end.to change(post.likes, :count).by(1)

    # いいねを解除する
    visit root_path

    click_link nil, href: "/posts/#{ post.id }"
    expect(current_path).to eq "/posts/#{ post.id }"

    expect do
      click_link 'unlike-btn'
      expect(page).to have_content '0'
    end.to change(post.likes, :count).by(-1)
  end
end
