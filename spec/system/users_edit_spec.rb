require 'rails_helper'

RSpec.describe 'Users_Edit', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザーが編集できること' do
    pending
    visit root_path

    find('.nav-icon').click
    find('.users-edit').click

    perform_enqueued_jobs do
      expect do
        fill_in 'UserName', with: 'エディットユーザー'
        fill_in 'Email', with: 'edit@example.com'
        attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/sample_user_image.jpg"
        fill_in 'Profile', with: 'こんにちは'
        fill_in 'CurrentPassword', with: 'password'
        click_button 'ユーザーを更新する'
      end.to change(User, :count).by(1)
      expect(page).to have_content 'エディットユーザー'
    end
  end
end
