require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'show' do
    it '正常にアクセスできること' do
      get post_path(post)
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end

end
