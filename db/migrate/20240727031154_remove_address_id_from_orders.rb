class RemoveAddressIdFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :address_id, :integer
  end
end
