# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  genre       :string(20)       not null
#  ingredients :string(200)      not null
#  memo        :string(200)      not null
#  title       :string(20)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
FactoryBot.define do
  factory :post do
    association :user
    title { 'オリジナルカクテル' }
    genre { 'ウイスキー' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/sample_post_image.jpg'))
    ingredients { '材料' }
    memo { '作り方メモ' }
  end
end
