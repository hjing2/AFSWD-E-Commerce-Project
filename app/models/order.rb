class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy
  has_many :order_histories
  has_many :products, through: :order_items

  PAYMENT_TYPES = ["Credit card", "PayPal", "Check"]

  validates :pay_type, :address_line, :city, :postal_code, :country, presence: true

  accepts_nested_attributes_for :order_items, allow_destroy: true

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "products", "user", "address", "province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address_id", "address_line", "city", "country", "created_at", "id", "is_paid", "is_shipped", "pay_type", "postal_code", "province_id", "total_price", "updated_at", "user_id"]
  end

  def calculate_total_price
    subtotal = order_items.sum(&:order_items_total_price)
    pst_rate = province.pst_rate
    gst_rate = province.gst_rate
    hst_rate = province.hst_rate

    pst = subtotal * pst_rate / 100
    gst = subtotal * gst_rate / 100
    hst = subtotal * hst_rate / 100

    self.total_price = subtotal + pst + gst + hst
  end

  def pst_amount
    subtotal = order_items.sum(&:order_items_total_price)
    pst_rate = province.pst_rate
    subtotal * pst_rate / 100
  end

  def gst_amount
    subtotal = order_items.sum(&:order_items_total_price)
    gst_rate = province.gst_rate
    subtotal * gst_rate / 100
  end

  def hst_amount
    subtotal = order_items.sum(&:order_items_total_price)
    hst_rate = province.hst_rate
    subtotal * hst_rate / 100
  end
end
