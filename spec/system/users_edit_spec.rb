require 'rails_helper'

RSpec.describe 'UsersEdit', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:guest_user) { create(:user, :guest_user) }

  it 'ユーザーが編集できること' do
    valid_login(user)
    expect(current_path).to eq "/users/#{ user.id }"

    # ヘッダーのドロワーメニューの(ユーザーを編集する)ボタンから編集
    find('.nav-icon-btn').click
    find('.users-edit').click
    perform_enqueued_jobs do
      fill_in 'UserName', with: 'エディットユーザー'
      fill_in 'Email', with: 'edit@example.com'
      attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/default_user_image.png"
      fill_in 'Profile', with: 'エディットユーザーです。'
      fill_in 'CurrentPassword', with: 'password'
      click_button 'ユーザーを更新する'
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'エディットユーザー'
      expect(page).to have_content 'エディットユーザーです。'
    end

    # マイプロフィール画面の(ユーザーを編集)ボタンから編集
    click_link 'ユーザーを編集'
    perform_enqueued_jobs do
      fill_in 'UserName', with: 'アップデートユーザー'
      fill_in 'Email', with: 'update@example.com'
      attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/default_user_image.png"
      fill_in 'Profile', with: 'アップデートユーザーです。'
      fill_in 'CurrentPassword', with: 'password'
      click_button 'ユーザーを更新する'
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'アップデートユーザー'
      expect(page).to have_content 'アップデートユーザーです。'
    end
  end

  context 'ゲストユーザーの場合' do
    it 'ゲストユーザーを編集しようとするとマイプロフィール画面にリダイレクトされること' do
      valid_guest_login(guest_user)
      expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      expect(current_path).to eq "/users/#{ guest_user.id }"

      # ヘッダーのドロワーメニューの(ユーザーを編集する)ボタンから編集
      find('.nav-icon-btn').click
      find('.users-edit').click
      perform_enqueued_jobs do
        fill_in 'UserName', with: 'エディットユーザー'
        fill_in 'Email', with: 'edit@example.com'
        attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/default_user_image.png"
        fill_in 'Profile', with: 'エディットユーザーです。'
        fill_in 'CurrentPassword', with: 'password'
        click_button 'ユーザーを更新する'
        expect(current_path).to eq user_path(guest_user)
        expect(page).to have_content 'ゲストユーザー'
        expect(page).to have_content 'ゲストユーザーです。'
      end

      # マイプロフィール画面の(ユーザーを編集)ボタンから編集
      click_link 'ユーザーを編集'
      perform_enqueued_jobs do
        fill_in 'UserName', with: 'アップデートユーザー'
        fill_in 'Email', with: 'update@example.com'
        attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/default_user_image.png"
        fill_in 'Profile', with: 'アップデートユーザーです。'
        fill_in 'CurrentPassword', with: 'password'
        click_button 'ユーザーを更新する'
        expect(current_path).to eq user_path(guest_user)
        expect(page).to have_content 'ゲストユーザー'
        expect(page).to have_content 'ゲストユーザーです。'
      end
    end
  end
end
