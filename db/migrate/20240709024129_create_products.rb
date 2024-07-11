class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :description
      t.decimal :price
      t.references :category, null: false, foreign_key: true
      t.string :image_url
      t.boolean :is_on_sale
      t.boolean :is_new
      t.boolean :is_recently_updated

      t.timestamps
    end
  end
end
