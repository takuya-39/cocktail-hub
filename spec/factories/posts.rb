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
#
FactoryBot.define do
  factory :post do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/sample_image.jpeg')) }
    genre { "ウイスキー" }
    title { "オリジナルカクテル" }
    memo { "作り方メモ" }
  end
end
