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

# delete old data
Product.delete_all
Category.delete_all

# read and create category
categories = {}
CSV.foreach(Rails.root.join('db', 'ogoki_apps.csv'), headers: true) do |row|
  category_name = row['Category']
  unless categories[category_name]
    category = Category.create!(category_name: category_name)
    categories[category_name] = category
  end
end

# read and create product
CSV.foreach(Rails.root.join('db', 'ogoki_apps.csv'), headers: true) do |row|
  category = categories[row['Category']]
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

puts "Seed data imported successfully!"
