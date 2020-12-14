# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
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
    username { 'takuya' }
    sequence(:email) { |n| "user#{ n }@example.com" }
    password { 'password' }
    profile { 'よろしくお願いします' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/user_a_image.jpg'))
  end

  trait :other_user do
    username { 'いっしー' }
    sequence(:email) { |n| "other#{ n }@example.com" }
    password { 'password' }
    profile { 'こんにちは！' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/user_b_image.jpg'))
  end

  trait :guest_user do
    username { 'ゲストユーザー' }
    email { 'guest@example.com' }
    password { 'password' }
    profile { 'ゲストユーザーです。' }
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/assets/default_user_image.png'))
  end
end
