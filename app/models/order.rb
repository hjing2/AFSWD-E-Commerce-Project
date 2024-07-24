class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :order_histories
  has_many :products, through: :order_items

  PAYMENT_TYPES = ["Credit card", "PayPal", "Check"]

  validates :pay_type, presence: true

  def calculate_total_price
    self.total_price = order_items.sum(&:order_items_total_price)
    pst_rate = address.province.pst_rate
    gst_rate = address.province.gst_rate
    hst_rate = address.province.hst_rate

    pst = total_price * pst_rate / 100
    gst = total_price * gst_rate / 100
    hst = total_price * hst_rate / 100

    self.total_price += pst + gst + hst
  end
end
