# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_post_id  (post_id)
#  index_likes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Likeモデル' do
    before do
      user = create(:user)
      post = create(:post)
      @like = Like.new(
        post_id: post.id,
        user_id: user.id
      )
    end

    it '有効なファクトリを持つこと' do
      expect(build(:like)).to be_valid
    end

    it 'いいねが有効であること' do
      expect(@like).to be_valid
    end
  end
end
