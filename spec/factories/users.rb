# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  profile                :string(200)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  username               :string(10)       not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    username { 'テストユーザー' }
    sequence(:email) { |n| "tester#{ n }@example.com" }
    password { 'password' }
    profile { 'プロフィールです。' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/sample_user_image.jpg'))
  end

  trait :otheruser do
    username { '他のユーザー' }
    sequence(:email) { |n| "other#{ n }@example.com" }
    password { 'password' }
    profile { '他のユーザーです。' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/sample_user_image.jpg'))
  end
end
