require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'いいね機能' do
    # ログインする
    valid_login(user)

    # 新規投稿する
    visit root_path
    find('.posts-new-btn').click
    expect(current_path).to eq new_post_path
    expect(page).to have_content '新規投稿'

    expect do
      fill_in 'Title', with: 'ホットココアスキー'
      select 'ウイスキー', from: 'Genre'
      attach_file 'Image', "#{ Rails.root }/spec/support/assets/sample_post_image.jpg"
      fill_in 'Ingredients', with: "・ウイスキー 30ml \n・ココアパウダー 5g \n・お湯 100ml".gsub(/(\\r\\n|\\r|\\n)/, "\n")
      fill_in 'Memo', with: "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n")
      click_button '投稿する'
    end.to change(Post, :count).by(1)

    post = Post.first

    # 投稿詳細ページに移動する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find('.post').click
    expect(current_path).to eq "/posts/#{ post.id }"

    # 投稿にいいねをする
    expect do
      click_link 'like-btn'
      expect(page).to have_content '1'
    end.to change(post.likes, :count).by(1)

    # いいねを解除する
    visit root_path

    find('.post').click
    expect(current_path).to eq "/posts/#{ post.id }"

    expect do
      click_link 'unlike-btn'
      expect(page).to have_content '0'
    end.to change(post.likes, :count).by(-1)
  end
end
