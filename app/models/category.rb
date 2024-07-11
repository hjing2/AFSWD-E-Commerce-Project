class Category < ApplicationRecord
  has_many :products

  # Specify searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[category_name]
  end
end
