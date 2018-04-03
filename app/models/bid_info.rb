class BidInfo < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates_presence_of :bid_price
end
