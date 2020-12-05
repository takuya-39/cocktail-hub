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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :default_image

  has_one_attached :image

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  validates :username, presence: true, length: { maximum: 10 }
  validates :profile, length: { maximum: 200 }

  def default_image
    image.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default_user_image.png')),
      filename: 'default_user_image.png',
      content_type: 'image/png'
    ) unless image.attached?
  end

  def display_image
    image.variant(resize: '1000^').processed
  end

  def self.guest
    find_or_create_by!(
      username: 'ゲストユーザー',
      email: 'guest@example.com'
    ) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
