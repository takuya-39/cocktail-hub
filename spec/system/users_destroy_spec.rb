require 'rails_helper'

RSpec.describe 'Users_Destroy', type: :system, js: true do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザーが削除できること' do
    pending
    expect(current_path).to user_path(user)
  end
end
