require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { build(:comment, post: post) }
  before do
    sign_in user
  end

  describe '#create' do
    context '正常なパラメータの場合' do
      it 'コメント投稿が成功すること' do
        expect do
          comment.save
        end.to change{ post.comments.count }.by 1
      end
    end
    context '不正なパラメータな場合' do
      it 'コメント投稿が失敗すること' do
        invalid_comment = build(:comment, post: post, content: '')
        expect do
          invalid_comment.save
        end.to change{ post.comments.count }.by 0
      end
    end
  end

  describe '#destroy' do
    it 'コメント削除が成功すること' do
      comment = create(:comment, post: post)
      expect { comment.destroy }.to change { post.comments.count }.by(-1)
    end
  end
end
