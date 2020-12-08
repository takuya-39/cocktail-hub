require 'rails_helper'

RSpec.describe 'PostsSearch', type: :system, js: true do
  include ActiveJob::TestHelper

  it '投稿一覧ページで投稿の検索ができること' do
    post_a = create(:post, title: 'サンプル', genre: 'ビール')
    post_b = create(:post, title: 'sample', genre: 'ウイスキー')

    # タイトルのワードで検索
    visit root_path
    expect(page).to have_selector ".post-#{ post_a.id }", text: 'サンプル'
    expect(page).to have_selector ".post-#{ post_b.id }", text: 'sample'
    expect(page).to have_selector '#posts-search-btn'

    find('#posts-search-btn').click
    fill_in '投稿検索ワードを入力', with: 'サンプル'
    expect(page).to have_selector ".post-#{ post_a.id }", text: 'サンプル'
    expect(page).not_to have_selector ".post-#{ post_b.id }", text: 'sample'

    fill_in '投稿検索ワードを入力', with: 'sample'
    expect(page).not_to have_selector ".post-#{ post_a.id }", text: 'サンプル'
    expect(page).to have_selector ".post-#{ post_b.id }", text: 'sample'

    # ジャンルのワードで検索
    fill_in '投稿検索ワードを入力', with: 'ビール'
    expect(page).to have_selector ".post-#{ post_a.id }", text: 'サンプル'
    expect(page).not_to have_selector ".post-#{ post_b.id }", text: 'sample'

    fill_in '投稿検索ワードを入力', with: 'ウイスキー'
    expect(page).not_to have_selector ".post-#{ post_a.id }", text: 'サンプル'
    expect(page).to have_selector ".post-#{ post_b.id }", text: 'sample'

    # リアルタイム検索
    fill_in '投稿検索ワードを入力', with: 'サ'
    expect(page).to have_selector ".post-#{ post_a.id }", text: 'サンプル'
    expect(page).not_to have_selector ".post-#{ post_b.id }", text: 'sample'
  end
end
