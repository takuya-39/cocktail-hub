require 'rails_helper'

RSpec.describe 'Posts', type: :system, js: true do
  post = FactoryBot.create(:post)

  it "新規投稿機能" do
    visit root_path
    click_on "posts-new"
    expect(current_path).to eq new_post_path
    expect(page).to have_content '新規投稿'

    expect {
      attach_file "Image", "#{Rails.root}/spec/support/assets/sample_image.jpeg", make_visible: true
      select "ウイスキー", from: "Genre"
      fill_in "Title", with: "オリジナルカクテル"
      fill_in "Memo", with: "作り方メモ"
      click_button "投稿する"
    }.to change(Post, :count).by(1)
  end
end