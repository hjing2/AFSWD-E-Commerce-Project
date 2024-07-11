class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price
      t.boolean :is_paid
      t.boolean :is_shipped
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
