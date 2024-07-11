ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :category_id, :image_url, :is_on_sale

  index do
    selectable_column
    id_column
    column :product_name
    column :description
    column :price
    column :category
    column :image do |product|
      if product.image_url.present?
        image_tag(product.image_url, size: "50x50")
      else
        "No Image"
      end
    end
    column :is_on_sale
    column :is_new
    column :is_recently_updated
    column :created_at
    column :updated_at
    actions
  end

  filter :product_name
  filter :category, as: :select, collection: -> { Category.all.pluck(:category_name, :id) }

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :description
      f.input :price
      f.input :category, as: :select, collection: Category.all.collect { |c| [c.category_name, c.id] }
      f.input :image_url
      f.input :is_on_sale
    end
    f.actions
  end
end
