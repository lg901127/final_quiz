class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :bid_price
      t.references :auction, index: true, foreign_key: true
      t.date :bid_date

      t.timestamps null: false
    end
  end
end
