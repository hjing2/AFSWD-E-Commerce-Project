ActiveAdmin.register OrderItem do
  permit_params :order_id, :product_id, :quantity, :order_items_total_price

  index do
    selectable_column
    id_column
    column :order
    column :product
    column :quantity
    column :order_items_total_price
    actions
  end

  filter :order
  filter :product
  filter :quantity
  filter :order_items_total_price

  form do |f|
    f.inputs do
      f.input :order
      f.input :product
      f.input :quantity
      f.input :order_items_total_price
    end
    f.actions
  end
end
