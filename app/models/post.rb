# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  genre      :string(20)       not null
#  memo       :string(200)      not null
#  title      :string(20)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :genre, presence: true, length: { maximum: 20 }
  validates :title, presence: true, length: { maximum: 20 }
  validates :memo, presence: true, length: { maximum: 200 }
end