require 'rails_helper'

RSpec.describe 'DrawerMenu', type: :system, js: true do
  it 'Cocktail Hubとは？ダイアログが正常に表示されること' do
    visit root_path
    find('.nav-icon-btn').click
    find('.drawer-explanation').click
    expect(page).to have_content 'あなたが作ったオリジナルカクテルをみんなと共有してみましょう！'
  end

  it 'いいねランキングダイアログが正常に表示されること' do
    visit root_path
    find('.nav-icon-btn').click
    find('.drawer-ranking').click
    expect(page).to have_content 'いいねランキング'
  end
end
