class OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart = current_cart
  end

  def create
    @order = Order.new(order_params)
    @order.add_items_from_cart(current_cart)
    if @order.save
      session[:cart] = nil
      redirect_to root_path, notice: 'Thank you for your order.'
    else
      @cart = current_cart
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address_id)
  end

  def calculate_total
    total = 0
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      total += product.price * quantity
    end
    total
  end

  def save_order_items
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create(product: product, quantity: quantity, order_items_total_price: product.price * quantity)
    end
  end

  def current_cart
    session[:cart] ||= {}
  end
end
