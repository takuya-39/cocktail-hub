require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Likeモデル' do
    before do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post)
      @like = Like.new(
        post_id: post.id,
        user_id: user.id
      )
    end

    it '有効なファクトリを持つこと' do
      expect(FactoryBot.build(:like)).to be_valid
    end

    it 'いいねが有効か' do
      expect(@like).to be_valid
    end
  end
end
