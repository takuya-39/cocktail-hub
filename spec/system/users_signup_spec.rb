require 'rails_helper'

RSpec.describe 'Signup', type: :system, js: true do
  include ActiveJob::TestHelper

  it 'ユーザーがサインアップできること' do
    visit root_path
    find('.nav-icon-btn').click
    find('.signup').click
    expect(current_path).to eq signup_path

    perform_enqueued_jobs do
      expect do
        fill_in 'UserName', with: 'サインアップユーザー'
        fill_in 'Email', with: 'signup@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'PasswordConfirmation', with: 'password'
        fill_in 'Profile', with: 'サインアップユーザーです。'
        attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/sample_user_image_cat.jpg"
        click_button '新規ユーザー登録をする'
      end.to change(User, :count).by(1)
    end
    expect(page).to have_content 'サインアップユーザー'
    expect(page).to have_content 'サインアップユーザーです。'
  end
end
