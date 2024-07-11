class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items
  has_many :order_histories
  has_many :products, through: :order_items
end
