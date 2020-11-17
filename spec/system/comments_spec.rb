require 'rails_helper'

RSpec.describe 'Comments', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }
  let(:otheruser) { FactoryBot.create(:user, :otheruser) }
  let(:post) { FactoryBot.create(:post) }

  it '既存の投稿にコメントをする、削除する' do
    valid_login(user)

    # 新規投稿する
    visit root_path
    find('.posts-new-btn').click
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
    find('.post').click
    expect(current_path).to eq "/posts/#{ post.id }"

    # 投稿にコメントをする
    fill_in 'Content', with: '美味しそう！'
    click_button 'コメントする'
    expect(page).to have_content '美味しそう！'

    # コメントを削除する
    comment = post.comments.find_by!(content: '美味しそう！')
    click_link 'コメントを削除'
    expect(page).to have_content 'コメントを削除しました'
    expect(Comment.where(id: comment.id)).to be_empty
  end
end
