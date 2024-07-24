class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items
  has_many :order_histories
  has_many :products, through: :order_items

  PAYMENT_TYPES = ["Credit card", "PayPal", "Check"]

  validates :name, :address, :email, :pay_type, presence: true
end
