require 'rails_helper'

RSpec.describe 'Posts', type: :system, js: true do
  let(:user) { create(:user) }

  it '新規投稿、投稿の編集、投稿の削除ができること' do
    valid_login(user)
    expect(current_path).to eq "/users/#{ user.id }"

    # 新規投稿する
    find('.posts-new-btn').click
    expect(current_path).to eq new_post_path
    expect(page).to have_content '新規投稿'

    expect do
      fill_in 'Title', with: 'ホットココアスキー'
      select 'ウイスキー', from: 'Genre'
      attach_file 'Image', "#{ Rails.root }/spec/support/assets/default_user_image.png"
      fill_in 'Ingredients', with: "・ウイスキー 30ml \n・ココアパウダー 5g \n・お湯 100ml".gsub(/(\\r\\n|\\r|\\n)/, "\n")
      fill_in 'Memo', with: "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n")
      click_button '投稿する'
    end.to change(Post, :count).by(1)

    post = Post.first

    aggregate_failures do
      expect(post.title).to eq 'ホットココアスキー'
      expect(post.genre).to eq 'ウイスキー'
      expect(post.ingredients).to eq "・ウイスキー 30ml \r\n・ココアパウダー 5g \r\n・お湯 100ml"
      expect(post.memo).to eq "耐熱グラスにココアパウダーを入れて、 \r\nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！"
      expect(current_path).to eq "/posts/#{ post.id }"
    end

    # 投稿を編集する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ post.id }").click
    expect(current_path).to eq "/posts/#{ post.id }"

    click_on '投稿を編集'
    expect(current_path).to eq edit_post_path(post)
    expect(page).to have_content '投稿編集'

    fill_in 'Memo', with: 'エディットメモ'
    click_button '更新する'
    expect(page).not_to have_content "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n")
    expect(page).to have_content 'エディットメモ'
    expect(current_path).to eq "/posts/#{ post.id }"

    # 投稿を削除する
    click_on '投稿を削除'
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_link "/posts/#{ post.id }"
    expect(current_path).to eq root_path
    expect(Post.where(id: post.id)).to be_empty
  end
end
