# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end

require 'csv'

# Ensure provinces exist
Province.find_or_create_by!(name: 'AB', pst_rate: 0.0, gst_rate: 5.0, hst_rate: 0.0)
Province.find_or_create_by!(name: 'BC', pst_rate: 7.0, gst_rate: 5.0, hst_rate: 0.0)
Province.find_or_create_by!(name: 'MB', pst_rate: 7.0, gst_rate: 5.0, hst_rate: 0.0)
Province.find_or_create_by!(name: 'NB', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 15.0)
Province.find_or_create_by!(name: 'NL', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 15.0)
Province.find_or_create_by!(name: 'NS', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 15.0)
Province.find_or_create_by!(name: 'NT', pst_rate: 0.0, gst_rate: 5.0, hst_rate: 0.0)
Province.find_or_create_by!(name: 'NU', pst_rate: 0.0, gst_rate: 5.0, hst_rate: 0.0)
Province.find_or_create_by!(name: 'ON', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 13.0)
Province.find_or_create_by!(name: 'PE', pst_rate: 0.0, gst_rate: 0.0, hst_rate: 15.0)
Province.find_or_create_by!(name: 'QC', pst_rate: 9.975, gst_rate: 5.0, hst_rate: 0.0)
Province.find_or_create_by!(name: 'SK', pst_rate: 6.0, gst_rate: 5.0, hst_rate: 0.0)
Province.find_or_create_by!(name: 'YT', pst_rate: 0.0, gst_rate: 5.0, hst_rate: 0.0)

# Read and create category
categories = {}
CSV.foreach(Rails.root.join('db', 'ogoki_apps.csv'), headers: true) do |row|
  category_name = row['Category']
  unless categories[category_name]
    category = Category.find_or_create_by!(category_name: category_name)
    categories[category_name] = category
  end
end

# Read and create product if it doesn't exist
CSV.foreach(Rails.root.join('db', 'ogoki_apps.csv'), headers: true) do |row|
  category = categories[row['Category']]
  unless Product.exists?(product_name: row['App Name'])
    Product.create!(
      product_name: row['App Name'],
      description: row['App description'],
      price: row['Price'],
      category: category,
      image_url: row['ImageUrl'],
      is_on_sale: false,
      is_new: true,
      is_recently_updated: false
    )
  end
end

puts "Seed data imported successfully!"
