class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  # https://stackoverflow.com/questions/36227578/reference-with-custom-name-and-foreign-key
  belongs_to :winning_bid, foreign_key: :winner_id, class_name: 'BidInfo', optional: true
  has_many :likes, as: :likeable
  has_many :report_from_others, as: :reportable, class_name: 'Report'
  validates_presence_of :type
  # https://stackoverflow.com/questions/27002946/rails-validates-presense-not-validating-on-boolean
  validates_inclusion_of :sell_type, in: [true, false]
  # https://stackoverflow.com/questions/1550688/how-do-i-create-a-default-value-for-attributes-in-rails-activerecords-model
  before_save :default_values
  has_paper_trail

  has_many :bid_infos, dependent: :destroy

  has_many :images, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :images,
                                :reject_if => proc {|attributes| attributes['content'].blank?},
                                :allow_destroy => true
  validates_presence_of :type
  ITEM_TYPES = ['BidItem', 'NonBidItem']

  def liked_by(user)
    self.likes << Like.new(user: user)
    self.save
  end

  def unliked_by(user)
    l = self.likes.find_by_user_id(user.id)
    if !l.nil?
      l.delete
      self.save
    else
      false
    end
  end

  def is_liked_by?(user)
    !self.likes.find_by_user_id(user.id).nil?
  end

  def is_reported_by?(user)
    !self.report_from_others.find_by_user_id(user.id).nil?
  end

  def contains_bid_info_by?(user)
    !self.bid_infos.find_by_user_id(user.id).nil?
  end

  def get_bid_info_by(user)
    self.bid_infos.find_by_user_id(user.id)
  end

  def is_bid_item?
    self.type == "BidItem"
  end

  def is_non_bid_item?
    self.type == "NonBidItem"
  end

  def price_msg
    if self.is_bid_item?
      if self.sell_type
        "Minimum Bidding"
      else
        "Maximum Bidding"
      end
    else
      if self.sell_type
        "Selling"
      else
        "Requesting"
      end
    end
  end

  def is_bidding_end?
    if self.is_bid_item?
      DateTime.now.utc > self.bid_end_time
    else
      false
    end
  end

  def validates_new_bid_price(bid_price)
    # Returing Hash {status: true/false, msg: 'notice or error' }
    if self.is_bid_item?
      if self.is_bidding_end?
        {status: false, msg: 'Sorry, Bidding Time out !'}
      else
        if self.sell_type
          # SELL BIDDING
          # Start from the current price as minimum price
          if self.bid_infos.size > 0
            if bid_price > self.bid_infos.order("bid_price DESC").first.bid_price
              {status: true, msg: 'Successfully raise a new bid'}
            else
              {status: false, msg: 'Sorry, your biding price is too low'}
            end
          else
            if bid_price > self.product_price
              {status: true, msg: 'Successfully raise a new bid'}
            else
              {status: false, msg: 'Sorry, your biding price is lower than minimum bidding price'}
            end
          end
        else
          # BUY BIDDING
          if self.bid_infos.size > 0
            if bid_price < self.bid_infos.order("bid_price ASC").first.bid_price
              {status: true, msg: 'Successfully raise a new bid'}
            else
              {status: false, msg: 'Sorry, your biding price is too high (Buying Item)'}
            end
          else
            if bid_price < self.product_price
              {status: true, msg: 'Successfully raise a new bid'}
            else
              {status: false, msg: 'Sorry, your biding price is higher than expected price (Buying Item)'}
            end
          end
        end
      end
    else
      {status: false, msg: 'This is not bidable Item'}
    end
  end

  def update_winning_bid
    if self.bid_infos.size > 0
      if self.sell_type
        self.winning_bid = self.bid_infos.order("bid_price DESC").first
      else
        self.winning_bid = self.bid_infos.order("bid_price ASC").first
      end
    else
      self.winning_bid = nil
    end
  end

  def sell_type_str
    self.sell_type ? "Sell" : "Buy"
  end

  private
  def default_values
    self.view_count ||= 0
    self.product_price ||= 0
    self.close_deal ||= false
  end
end

