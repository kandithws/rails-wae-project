class CreateBidInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :bid_infos do |t|
      t.decimal :bid_price
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
