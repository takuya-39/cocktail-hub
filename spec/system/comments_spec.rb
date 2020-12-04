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
