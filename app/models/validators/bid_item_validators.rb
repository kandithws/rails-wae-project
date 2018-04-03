# https://stackoverflow.com/questions/25709125/ruby-on-rails-validate-datetime-before-save
class BidItemValidator < ActiveModel::Validator
  def validate(record)
    unless record.bid_end_time.nil?
      if record.bid_end_time < Time.now + 60
        record.errors[:base] << 'Bidding End time must be specified at least a minute from now'
      end
    end
  end
end