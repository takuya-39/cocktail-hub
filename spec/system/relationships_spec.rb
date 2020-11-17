require 'rails_helper'

RSpec.describe 'Relationships', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }
  let(:otheruser) { FactoryBot.create(:user, :otheruser) }

  it 'フォロー機能' do
    # ユーザーAがユーザーBをフォローする
    pending
    valid_login(user)

    visit root_path
    expect(page).to have_content 'ユーザーAのカクテル'
    expect(page).to have_content 'ユーザーBのカクテル'
    find('.post').click
    find('.post-user').click
    expect(current_path).to eq "/users/#{ otheruser.id }"

    expect do
      click_link 'フォローする'
      expect(page).to have_content 'フォロー中'
    end.to change(user.follow_id, :count).by(1) &
           change(otheruser.user_id, :count).by(1)

    # # ユーザーBのフォローを解除する
    # visit user_path(user)
    # expect(current_path).to eq "/users/#{user.id}"

    # expect do
    #   click_link 'フォロー中'
    #   expect(page).to have_content 'フォローする'
    # end.to change(user.followings, :count).by(0) &
    #        change()
  end
end
