# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  genre      :string(20)       not null
#  memo       :string(200)      not null
#  title      :string(20)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Postモデル" do

    it "有効なファクトリを持つこと" do
      expect(FactoryBot.build(:post)).to be_valid
    end

    it "ジャンル、タイトル、メモがあれば有効な状態であること" do
      post = Post.new(
        genre: "ウイスキー",
        title: "オリジナルカクテル",
        memo: "作り方メモ",
      )
      expect(post).to be_valid
    end

    describe "genre" do
      it "ジャンルが無ければ無効な状態であること" do
        post = FactoryBot.build(:post, genre: nil)
        post.valid?
        expect(post.errors[:genre]).to include(I18n.t("errors.messages.blank"))
      end
      context "文字数" do
        it "文字数が20文字以下なら有効であること" do
          post = FactoryBot.build(:post, genre: "a" * 10)
          expect(post).to be_valid
        end
        it "文字数が20文字を超えると無効であること" do
          post = FactoryBot.build(:post, genre: "a" * 21)
          expect(post).not_to be_valid
        end
      end
    end

    describe "title" do
      it "タイトルが無ければ無効な状態であること" do
        post = FactoryBot.build(:post, title: nil)
        post.valid?
        expect(post.errors[:title]).to include(I18n.t("errors.messages.blank"))
      end
      context "文字数" do
        it "文字数が20文字以下なら有効であること" do
          post = FactoryBot.build(:post, title: "a" * 10)
          expect(post).to be_valid
        end
        it "文字数が20文字を超えると無効であること" do
          post = FactoryBot.build(:post, title: "a" * 21)
          expect(post).not_to be_valid
        end
      end
    end

    describe "memo" do
      it "メモが無ければ無効な状態であること" do
        post = FactoryBot.build(:post, memo: nil)
        post.valid?
        expect(post.errors[:memo]).to include(I18n.t("errors.messages.blank"))
      end
      context "文字数" do
        it "文字数が200文字以下なら有効であること" do
          post = FactoryBot.build(:post, memo: "a" * 100)
          expect(post).to be_valid
        end
        it "文字数が200文字を超えると無効であること" do
          post = FactoryBot.build(:post, memo: "a" * 201)
          expect(post).not_to be_valid
        end
      end
    end
  end
end


# it "contentの文字数が140文字を超えると無効なこと" do
#   micropost.content = "a" * 141
#   expect(micropost).to_not be_valid
# end
