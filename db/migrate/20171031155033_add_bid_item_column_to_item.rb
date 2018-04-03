class AddBidItemColumnToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :bid_end_time, :datetime
    add_column :items, :winner_id, :integer
    # add_foreign_key :posts, :users, column: :winner_id
  end
end
