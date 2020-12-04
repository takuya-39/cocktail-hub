# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  profile                :string(200)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  username               :string(10)       not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデル' do
    it '有効なファクトリを持つこと' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it 'ユーザーネーム、メールアドレス、パスワード、ユーザー画像があれば有効な状態であること' do
      user = User.new(
        username: 'ゲストユーザー',
        email: 'guest@example.com',
        password: 'password',
        profile: 'ゲストユーザーです。',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/sample_user_image_cat.jpg'))
      )
      expect(user).to be_valid
    end

    describe 'username' do
      it 'ユーザーネームが無ければ無効な状態であること' do
        user = FactoryBot.build(:user, username: nil)
        user.valid?
        expect(user.errors[:username]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が10文字以下なら有効であること' do
          user = FactoryBot.build(:user, username: 'a' * 5)
          expect(user).to be_valid
        end
        it '文字数が10文字以上なら無効であること' do
          user = FactoryBot.build(:user, username: 'a' * 11)
          expect(user).not_to be_valid
        end
      end
    end

    describe 'email' do
      it 'メールアドレスが無ければ無効な状態であること' do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
      end
    end

    describe 'password' do
      it 'パスワードが無ければ無効な状態であること' do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include(I18n.t('errors.messages.blank'))
      end
    end

    describe 'profile' do
      context '文字数' do
        it '文字数が200文字以下なら有効であること' do
          user = FactoryBot.build(:user, profile: 'a' * 100)
          expect(user).to be_valid
        end
        it '文字数が200文字を超えると無効であること' do
          user = FactoryBot.build(:user, profile: 'a' * 201)
          expect(user).not_to be_valid
        end
      end
    end

    describe 'image' do
      it 'ユーザー画像が無ければ無効な状態であること' do
        post = FactoryBot.build(:post, image: nil)
        post.valid?
        expect(post.errors[:image]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
