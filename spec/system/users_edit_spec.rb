require 'rails_helper'

RSpec.describe 'Users_Edit', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザーが編集できること' do
    valid_login(user)

    visit root_path
    find('.nav-icon-btn').click
    find('.users-edit').click

    perform_enqueued_jobs do
      fill_in 'UserName', with: 'エディットユーザー'
      fill_in 'Email', with: 'edit@example.com'
      attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/sample_user_image_cat.jpg"
      fill_in 'Profile', with: 'こんにちは'
      fill_in 'CurrentPassword', with: 'password'
      click_button 'ユーザーを更新する'

      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'エディットユーザー'
      expect(page).to have_content 'こんにちは'
    end
  end

  context 'ゲストユーザー' do
    it 'ゲストユーザーを編集しようとするとホーム画面にリダイレクトされること' do
      valid_guest_login(user)
      visit root_path

      find('.nav-icon-btn').click
      find('.users-edit').click

      perform_enqueued_jobs do
        expect do
          fill_in 'UserName', with: 'エディットユーザー'
          fill_in 'Email', with: 'edit@example.com'
          attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/sample_user_image_cat.jpg"
          fill_in 'Profile', with: 'こんにちは'
          fill_in 'CurrentPassword', with: 'password'
          click_button 'ユーザーを更新する'
        end.to change(User, :count).by(0)

        expect(current_path).to eq root_path
      end
    end
  end
end
