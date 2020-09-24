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
      expect(FactoryBot.build(:comment)).to be_valid
    end

    context 'コメント内容' do
      it 'コメント内容があれば有効な状態であること' do
        comment = Comment.new(
          user: FactoryBot.create(:user),
          post: FactoryBot.create(:post),
          content: 'サンプルのコメントです'
        )
        expect(comment).to be_valid
      end

      it 'コメント内容が無ければ無効な状態であること' do
        comment = FactoryBot.build(:comment, content: nil)
        comment.valid?
        expect(comment.errors[:content]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context '文字数' do
      it '文字数が200文字以下なら有効であること' do
        comment = FactoryBot.build(:comment, content: 'a' * 100)
        expect(comment).to be_valid
      end
      it '文字数が200文字を超えると無効であること' do
        comment = FactoryBot.build(:comment, content: 'a' * 201)
        expect(comment).not_to be_valid
      end
    end
  end
end
