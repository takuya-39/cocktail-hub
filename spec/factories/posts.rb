# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  genre       :string(20)       not null
#  ingredients :string(200)      default("・ \n・ \n・ \n・ \n・"), not null
#  memo        :string(200)      not null
#  title       :string(20)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
FactoryBot.define do
  factory :post do
    association :user
    title { '塩エルディアブロ' }
    genre { 'テキーラ' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/user_a_post_image.jpg'))
    ingredients { "・テキーラ 50ml \n・カシスリキュール 20ml \n・ジンジャーエール 適量 \n・塩(縁に付けるかそのまま入れる) 5g \n・カットライム、ライム果汁 お好みで量を調整".gsub(/(\\r\\n|\\r|\\n)/, "\n") }
    memo { "テキーラとカシスを混ぜてジンジャーエールで割ります、 \n塩とライムを入れて完成です！ \n塩とライムの量多めでよりさっぱりとした仕上がりになります！".gsub(/(\\r\\n|\\r|\\n)/, "\n") }
  end

  trait :other_post do
    association :other_user
    title { 'お手軽サングリア' }
    genre { 'ワイン' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/user_b_post_image.jpg'))
    ingredients { "・赤ワイン 半分 \n・オランジーナ 半分".gsub(/(\\r\\n|\\r|\\n)/, "\n") }
    memo { '赤ワインとオランジーナを一対一で割るだけ！簡単で美味しいよ！' }
  end
end
