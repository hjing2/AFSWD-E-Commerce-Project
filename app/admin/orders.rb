ActiveAdmin.register Order do
  permit_params :user_id, :total_price, :is_paid, :is_shipped, :address_id, :pay_type, :address_line, :city, :province_id, :postal_code, :country

  index do
    selectable_column
    id_column
    column :user
    column :total_price
    column :is_paid
    column :is_shipped
    column :address_line
    column :city
    column :province
    column :postal_code
    column :country
    column :pay_type
    column :is_new do |order|
      order.is_new? ? 'YES' : 'NO'
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :user
  filter :total_price
  filter :is_paid
  filter :is_shipped
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :total_price
      f.input :is_paid
      f.input :is_shipped
      f.input :address_line
      f.input :city
      f.input :province
      f.input :postal_code
      f.input :country, as: :string
      f.input :pay_type
    end
    f.actions
  end
end
