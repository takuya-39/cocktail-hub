require 'rails_helper'

RSpec.describe 'Comments', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }
  let!(:post) { create(:post, user: user) }

  it '既存の投稿にコメントをする、削除する' do
    # other_userがログインする
    valid_login(other_user)
    expect(current_path).to eq "/users/#{ other_user.id }"

    # 投稿詳細ページに移動する
    find('.nav-icon-btn').click
    find('.go-root').click
    expect(current_path).to eq root_path

    find(".post-#{ post.id }").click
    expect(current_path).to eq "/posts/#{ post.id }"

    # 投稿にコメントをする
    fill_in 'Content', with: '美味しそう！'
    click_button 'コメントする'
    expect(page).to have_content '美味しそう！'

    fill_in 'Content', with: '作ってみたい！'
    click_button 'コメントする'
    expect(page).to have_content '作ってみたい！'

    # コメントを削除する
    comment = post.comments.find_by!(content: '美味しそう！')
    click_link 'コメントを削除', href: "/posts/#{ post.id }/comments/#{ comment.id }"
    expect(page).to have_content 'コメントを削除しました'
    expect(Comment.where(id: comment.id)).to be_empty
  end
end
