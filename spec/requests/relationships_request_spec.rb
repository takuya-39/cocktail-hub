require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let(:user) { create(:user) }
  let(:otheruser) { create(:user, :otheruser) }
  before do
    sign_in user
  end

  describe '#create' do
    it 'フォローが成功すること' do
      expect do
        create(:relationship, follow_id: otheruser.id, user_id: user.id)
      end.to change{ [otheruser.followers.count, user.followings.count] }.to [1, 1]
    end
  end

  describe '#destroy' do
    it 'フォロー解除が成功すること' do
      pending
      relationship = create(:relationship, follow_id: otheruser.id, user_id: user.id)
      expect do
        relationship.destroy
      end.to change{ [otheruser.followers.count, user.followings.count] }.to [-1, -1]
    end
  end
end
