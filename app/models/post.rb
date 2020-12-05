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
class Post < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true, length: { maximum: 20 }
  validates :genre, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  validates :ingredients, presence: true, length: { maximum: 200 }
  validates :memo, presence: true, length: { maximum: 200 }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def display_image
    image.variant(resize: '1000^').processed
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
