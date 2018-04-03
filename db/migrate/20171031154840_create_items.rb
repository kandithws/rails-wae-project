class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :type
      t.integer :view_count
      t.text :body
      t.boolean :sell_type
      t.string :product_name
      t.text :product_desc
      t.string :product_ref_url
      t.decimal :product_price
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
