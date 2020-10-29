require 'rails_helper'

RSpec.describe 'Posts', type: :system, js: true do
  it '新規投稿、編集, 削除' do
    user = FactoryBot.create(:user)
    valid_login(user)

    # 新規投稿
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

    aggregate_failures do
      expect(post.title).to eq 'オリジナルカクテル'
      expect(post.genre).to eq 'ウイスキー'
      expect(post.ingredients).to eq '材料'
      expect(post.memo).to eq '作り方メモ'
      expect(current_path).to eq root_path
    end

    # 投稿編集
    find('.post').click
    expect(current_path).to eq "/posts/#{ post.id }"

    click_on 'メモを編集'
    expect(current_path).to eq edit_post_path(post)
    expect(page).to have_content '投稿編集'

    fill_in 'Memo', with: 'サンプルメモ'
    click_button '更新する'

    expect(page).not_to have_content '作り方メモ'
    expect(page).to have_content 'サンプルメモ'
    expect(current_path).to eq "/posts/#{ post.id }"

    # 投稿削除
    expect do
      click_on '投稿を削除'
    end.to change(Post, :count).by(-1)
    expect(current_path).to eq root_path
  end
end
