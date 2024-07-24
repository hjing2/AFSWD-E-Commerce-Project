class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :order_histories
  has_many :products, through: :order_items

  PAYMENT_TYPES = ["Credit card", "PayPal", "Check"]

  validates :pay_type, presence: true

  before_save :calculate_total_price

  def calculate_total_price
    subtotal = order_items.sum(:order_items_total_price)
    pst_rate = address.province.pst_rate
    gst_rate = address.province.gst_rate
    hst_rate = address.province.hst_rate

    pst = subtotal * pst_rate / 100
    gst = subtotal * gst_rate / 100
    hst = subtotal * hst_rate / 100

    self.total_price = subtotal + pst + gst + hst
  end

  def pst_amount
    order_items.sum(:order_items_total_price) * address.province.pst_rate / 100
  end

  def gst_amount
    order_items.sum(:order_items_total_price) * address.province.gst_rate / 100
  end

  def hst_amount
    order_items.sum(:order_items_total_price) * address.province.hst_rate / 100
  end
end
