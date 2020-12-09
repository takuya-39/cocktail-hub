# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :string(200)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Commentモデル' do
    it '有効なファクトリを持つこと' do
      expect(build(:comment)).to be_valid
    end

    describe 'コメント内容' do
      it 'コメント内容があれば有効な状態であること' do
        comment = Comment.new(
          user: create(:user),
          post: create(:post),
          content: 'サンプルのコメントです'
        )
        expect(comment).to be_valid
      end

      it 'コメント内容が無ければ無効な状態であること' do
        comment = build(:comment, content: nil)
        comment.valid?
        expect(comment.errors[:content]).to include(I18n.t('errors.messages.blank'))
      end
    end

    describe '文字数' do
      it '文字数が200文字以下なら有効であること' do
        comment = build(:comment, content: 'a' * 100)
        expect(comment).to be_valid
      end
      it '文字数が200文字を超えると無効であること' do
        comment = build(:comment, content: 'a' * 201)
        expect(comment).not_to be_valid
      end
    end

    describe '並び順' do
      it 'コメントが新しい順に並んでいること' do
        post = create(:post)
        post.comments.create(created_at: 3.days.ago)
        post.comments.create(created_at: 10.minutes.ago)
        latest_comment = post.comments.create(created_at: Time.zone.now)
        expect(latest_comment).to eq post.comments.last
      end
    end
  end
end
