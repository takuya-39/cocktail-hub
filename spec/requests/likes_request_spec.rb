require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:like) { build(:like, post: post) }
  before do
    sign_in user
  end

  describe '#create' do
    it 'いいねが成功すること' do
      expect do
        like.save
      end.to change{ post.likes.count }.by 1
    end
  end

  describe '#destroy' do
    it 'いいね解除が成功すること' do
      like = create(:like, post: post)
      expect { like.destroy }.to change { post.likes.count }.by(-1)
    end
  end
end
