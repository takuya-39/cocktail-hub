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
      expect(FactoryBot.build(:post)).to be_valid
    end

    it 'タイトル、ジャンル、画像、材料、メモがあれば有効な状態であること' do
      post = Post.new(
        user: FactoryBot.build(:user),
        title: 'ホットココアスキー',
        genre: 'ウイスキー',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/sample_post_image.jpg')),
        ingredients: "・ウイスキー 30ml \n・ココアパウダー 5g \n・お湯 100ml".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
        memo: "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n")
      )
      expect(post).to be_valid
    end

    describe 'title' do
      it 'タイトルが無ければ無効な状態であること' do
        post = FactoryBot.build(:post, title: nil)
        post.valid?
        expect(post.errors[:title]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が20文字以下なら有効であること' do
          post = FactoryBot.build(:post, title: 'a' * 10)
          expect(post).to be_valid
        end
        it '文字数が20文字を超えると無効であること' do
          post = FactoryBot.build(:post, title: 'a' * 21)
          expect(post).not_to be_valid
        end
      end
    end

    describe 'genre' do
      it 'ジャンルが無ければ無効な状態であること' do
        post = FactoryBot.build(:post, genre: nil)
        post.valid?
        expect(post.errors[:genre]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が20文字以下なら有効であること' do
          post = FactoryBot.build(:post, genre: 'a' * 10)
          expect(post).to be_valid
        end
        it '文字数が20文字を超えると無効であること' do
          post = FactoryBot.build(:post, genre: 'a' * 21)
          expect(post).not_to be_valid
        end
      end
    end

    describe 'image' do
      it '画像が無ければ無効な状態であること' do
        post = FactoryBot.build(:post, image: nil)
        post.valid?
        expect(post.errors[:image]).to include(I18n.t('errors.messages.blank'))
      end
    end

    describe 'ingredients' do
      it '材料が無ければ無効な状態であること' do
        post = FactoryBot.build(:post, ingredients: nil)
        post.valid?
        expect(post.errors[:ingredients]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が200文字以下なら有効であること' do
          post = FactoryBot.build(:post, ingredients: 'a' * 100)
          expect(post).to be_valid
        end
        it '文字数が200文字を超えると無効であること' do
          post = FactoryBot.build(:post, ingredients: 'a' * 201)
          expect(post).not_to be_valid
        end
      end
    end

    describe 'memo' do
      it 'メモが無ければ無効な状態であること' do
        post = FactoryBot.build(:post, memo: nil)
        post.valid?
        expect(post.errors[:memo]).to include(I18n.t('errors.messages.blank'))
      end
      context '文字数' do
        it '文字数が200文字以下なら有効であること' do
          post = FactoryBot.build(:post, memo: 'a' * 100)
          expect(post).to be_valid
        end
        it '文字数が200文字を超えると無効であること' do
          post = FactoryBot.build(:post, memo: 'a' * 201)
          expect(post).not_to be_valid
        end
      end
    end
  end
end
