class CreateOrderHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :order_histories do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :price_at_order

      t.timestamps
    end
  end
end
