require 'validators/bid_item_validators'
class BidItem < Item
  validates_presence_of :bid_end_time
  include ActiveModel::Validations
  validates_with BidItemValidator
end

