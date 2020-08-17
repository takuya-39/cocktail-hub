require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  describe 'show' do
    it '正常にアクセスできること' do
      pending
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end
end
