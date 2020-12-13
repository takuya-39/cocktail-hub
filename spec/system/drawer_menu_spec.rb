require 'rails_helper'

RSpec.describe 'DrawerMenu', type: :system, js: true do
  let(:user) { create(:user) }

  context 'Cocktail Hubとは？' do
    it 'Cocktail Hubとは？ダイアログが正常に表示されること' do
      visit root_path
      find('.nav-icon-btn').click
      find('.drawer-explanation').click
      expect(page).to have_content 'あなたが作ったオリジナルカクテルをみんなと共有してみましょう！'
    end
  end

  context 'いいねランキング' do
    it 'いいねランキングダイアログが正常に表示されること' do
      post_a = create(:post, title: '1位の投稿')
      post_b = create(:post, title: '2位の投稿')
      post_c = create(:post, title: '3位の投稿')
      create_list(:like, 3, post: post_a)
      create_list(:like, 2, post: post_b)
      create_list(:like, 1, post: post_c)
      visit root_path
      find('.nav-icon-btn').click
      find('.drawer-ranking').click
      expect(page).to have_selector '.index-0', text: '1位の投稿'
      expect(page).to have_selector '.index-1', text: '2位の投稿'
      expect(page).to have_selector '.index-2', text: '3位の投稿'
    end
  end

  context 'ランダム' do
    it 'ランダムダイアログが正常に表示されること' do
      # post_a = create(:post, title: '投稿A')
      # post_b = create(:post, title: '投稿B')
      # post_c = create(:post, title: '投稿C')
      visit root_path
      find('.nav-icon-btn').click
      find('.drawer-random').click
      expect(page).to have_content 'ランダム'
    end
  end
end
