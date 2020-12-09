# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  genre       :string(20)       not null
#  ingredients :string(200)      default("・ \n・ \n・ \n・ \n・"), not null
#  memo        :string(200)      not null
#  title       :string(20)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Postモデル' do
    it '有効なファクトリを持つこと' do
      expect(build(:post)).to be_valid
    end

    it 'タイトル、ジャンル、画像、材料、メモがあれば有効な状態であること' do
      post = Post.new(
        user: build(:user),
        title: 'ホットココアスキー',
        genre: 'ウイスキー',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/default_user_image.png')),
        ingredients: "・ウイスキー 30ml \n・ココアパウダー 5g \n・お湯 100ml".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
        memo: "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n")
      )
      expect(post).to be_valid
    end

    describe 'タイトル' do
      it 'タイトルが無ければ無効な状態であること' do
        post = build(:post, title: nil)
        post.valid?
        expect(post.errors[:title]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が20文字以下なら有効であること' do
          post = build(:post, title: 'a' * 10)
          expect(post).to be_valid
        end
        it '文字数が20文字を超えると無効であること' do
          post = build(:post, title: 'a' * 21)
          expect(post).not_to be_valid
          expect(post.errors[:title]).to include(I18n.t('errors.messages.too_long', count: 20))
        end
      end
    end

    describe 'ジャンル' do
      it 'ジャンルが無ければ無効な状態であること' do
        post = build(:post, genre: nil)
        post.valid?
        expect(post.errors[:genre]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が20文字以下なら有効であること' do
          post = build(:post, genre: 'a' * 10)
          expect(post).to be_valid
        end
        it '文字数が20文字を超えると無効であること' do
          post = build(:post, genre: 'a' * 21)
          expect(post).not_to be_valid
          expect(post.errors[:genre]).to include(I18n.t('errors.messages.too_long', count: 20))
        end
      end
    end

    describe '画像' do
      it '画像が無ければ無効な状態であること' do
        post = build(:post, image: nil)
        post.valid?
        expect(post.errors[:image]).to include(I18n.t('errors.messages.blank'))
      end
    end

    describe '材料' do
      it '材料が無ければ無効な状態であること' do
        post = build(:post, ingredients: nil)
        post.valid?
        expect(post.errors[:ingredients]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が200文字以下なら有効であること' do
          post = build(:post, ingredients: 'a' * 100)
          expect(post).to be_valid
        end
        it '文字数が200文字を超えると無効であること' do
          post = build(:post, ingredients: 'a' * 201)
          expect(post).not_to be_valid
          expect(post.errors[:ingredients]).to include(I18n.t('errors.messages.too_long', count: 200))
        end
      end
    end

    describe 'メモ' do
      it 'メモが無ければ無効な状態であること' do
        post = build(:post, memo: nil)
        post.valid?
        expect(post.errors[:memo]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が200文字以下なら有効であること' do
          post = build(:post, memo: 'a' * 100)
          expect(post).to be_valid
        end
        it '文字数が200文字を超えると無効であること' do
          post = build(:post, memo: 'a' * 201)
          expect(post).not_to be_valid
          expect(post.errors[:memo]).to include(I18n.t('errors.messages.too_long', count: 200))
        end
      end
    end

    describe 'いいね機能' do
      it '投稿をいいね、いいね解除できること' do
        user = create(:user)
        other_user = create(:user, :other_user)
        other_post = create(:post, user_id: other_user.id)
        expect(other_post.liked_by?(user)).to eq false
        like = other_post.likes.create(user_id: user.id)
        expect(other_post.liked_by?(user)).to eq true
        like.destroy
        expect(other_post.liked_by?(user)).to eq false
      end
    end

    describe '並び順' do
      it '投稿が新しい順に並んでいること' do
        create(:post, created_at: 3.days.ago)
        create(:post, created_at: 10.minutes.ago)
        latest_post = create(:post, created_at: Time.zone.now)
        expect(latest_post).to eq Post.last
      end
    end

    describe '付従性' do
      it '投稿を削除すると関連するコメントも削除されること' do
        post = create(:post)
        create(:comment, post: post)
        expect { post.destroy }.to change { Comment.count }.by(-1)
      end
      it '投稿を削除すると関連するいいねも削除されること' do
        post = create(:post)
        create(:like, post: post)
        expect { post.destroy }.to change { Like.count }.by(-1)
      end
    end
  end
end
