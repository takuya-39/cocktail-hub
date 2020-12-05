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

    describe 'ユーザーネーム' do
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
          expect(user.errors[:username]).to include(I18n.t('errors.messages.too_long', count: 10))
        end
      end
    end

    describe 'メールアドレス' do
      it 'メールアドレスが無ければ無効な状態であること' do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
      end
      it 'メールアドレスが小文字で保存されること' do
        user = FactoryBot.create(:user, email: 'TeSt@ExAmPlE.CoM')
        expect(user.email).to eq 'test@example.com'
      end
      context '一意性' do
        it '重複したメールアドレスなら無効であること' do
          user_a = FactoryBot.create(:user, username: 'ユーザーA', email: 'taro@example.com')
          user_b = FactoryBot.build(:user, username: 'ユーザーB', email: user_a.email)
          expect(user_b).not_to be_valid
          expect(user_b.errors[:email]).to include(I18n.t('errors.messages.taken'))
        end
        it 'メールアドレスは大文字小文字を区別しないこと' do
          FactoryBot.create(:user, email: 'test@example.com')
          duplicate_user = FactoryBot.build(:user, email: 'TEST@EXAMPLE.COM')
          duplicate_user.valid?
          expect(duplicate_user.errors[:email]).to include(I18n.t('errors.messages.taken'))
        end
      end
      context 'フォーマット' do
        it 'メールアドレスが正常なフォーマットなら有効であること' do
          user = FactoryBot.create(:user, email: 'test@example.com')
          expect(user).to be_valid
        end
        it 'メールアドレスが不正なフォーマットなら無効であること' do
          user = FactoryBot.build(:user, email: 'testexamplecom')
          expect(user).not_to be_valid
        end
      end
    end

    describe 'パスワード' do
      it 'パスワードが無ければ無効な状態であること' do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include(I18n.t('errors.messages.blank'))
      end
    end

    describe 'プロフィール' do
      context '文字数' do
        it '文字数が200文字以下なら有効であること' do
          user = FactoryBot.build(:user, profile: 'a' * 100)
          expect(user).to be_valid
        end
        it '文字数が200文字を超えると無効であること' do
          user = FactoryBot.build(:user, profile: 'a' * 201)
          expect(user).not_to be_valid
          expect(user.errors[:profile]).to include(I18n.t('errors.messages.too_long', count: 200))
        end
      end
    end

    describe '画像' do
      it 'ユーザー画像が無ければ無効な状態であること' do
        post = FactoryBot.build(:post, image: nil)
        post.valid?
        expect(post.errors[:image]).to include(I18n.t('errors.messages.blank'))
      end
    end

    describe 'フォロー機能' do
      it 'ユーザーをフォロー、フォロー解除できること' do
        user = FactoryBot.create(:user)
        otheruser = FactoryBot.create(:user, :otheruser)
        expect(otheruser.following?(user)).to eq false
        otheruser.follow(user)
        expect(otheruser.following?(user)).to eq true
        otheruser.unfollow(user)
        expect(otheruser.following?(user)).to eq false
      end
    end

    describe '付従性' do
      it 'ユーザーを削除すると関連する投稿も削除されること' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:post, user: user)
        expect { user.destroy }.to change { Post.count }.by(-1)
      end
      it 'ユーザーを削除すると関連するコメントも削除されること' do
        user = FactoryBot.create(:user)
        otheruser = FactoryBot.create(:user, :otheruser)
        otherpost = FactoryBot.create(:post, user: otheruser)
        FactoryBot.create(:comment, post_id: otherpost.id, user_id: user.id)
        expect { user.destroy }.to change { otherpost.comments.count }.by(-1)
      end
      it 'ユーザーを削除すると関連するいいねも削除されること' do
        user = FactoryBot.create(:user)
        otheruser = FactoryBot.create(:user, :otheruser)
        otherpost = FactoryBot.create(:post, user: otheruser)
        otherpost.likes.create(user_id: user.id)
        expect { user.destroy }.to change { otherpost.likes.count }.by(-1)
      end
      it 'ユーザーを削除すると関連するフォロー関係も削除されること' do
        user = FactoryBot.create(:user)
        otheruser = FactoryBot.create(:user, :otheruser)
        user.follow(otheruser)
        expect { user.destroy }.to change { otheruser.followers.count }.by(-1)
      end
    end
  end
end
