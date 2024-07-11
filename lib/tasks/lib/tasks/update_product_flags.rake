namespace :update_product_flags do
  desc "Update is_new and is_recently_updated flags for all products"
  task update: :environment do
    Product.find_each do |product|
      # Manually set created_at and updated_at timestamps to ensure correctness
      product.created_at ||= product.created_at
      product.updated_at ||= product.updated_at
      # Update the flags based on current timestamps
      product.update_new_and_recently_updated_flags
      # Save without validation to ensure all records are saved
      product.save(validate: false)
    end
    puts "Updated is_new and is_recently_updated flags for all products."
  end
end
