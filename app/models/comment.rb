class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :likes, as: :likeable # to get likes; c.likes
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images
  has_paper_trail
end
