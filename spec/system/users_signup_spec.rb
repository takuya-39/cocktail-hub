require 'rails_helper'

RSpec.describe 'Signup', type: :system, js: true do
  include ActiveJob::TestHelper

  it 'ユーザーがサインアップできること' do
    visit root_path

    find('.nav-icon').click
    find('.signup').click

    perform_enqueued_jobs do
      expect do
        fill_in 'UserName', with: 'テストユーザー'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'PasswordConfirmation', with: 'password'
        attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/sample_user_image_cat.jpg"
        click_button '新規ユーザー登録をする'
      end.to change(User, :count).by(1)

      expect(current_path).to eq root_path
    end
  end
end
