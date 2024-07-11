class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :order_histories
  has_many :orders, through: :order_items

  # Specify searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[category]
  end

  # Specify searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[product_name category_id]
  end

  before_update :update_new_and_recently_updated_flags

  def update_new_and_recently_updated_flags
    self.is_new = created_at >= 3.days.ago
    self.is_recently_updated = updated_at >= 3.days.ago && created_at < 3.days.ago
  end
end
