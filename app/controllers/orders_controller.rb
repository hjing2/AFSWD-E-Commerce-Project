class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @cart = current_cart
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.address = current_user.current_address

    if @order.save
      save_order_items
      @order.calculate_total_price
      @order.save
      session[:cart] = {}
      redirect_to @order, notice: "Order successfully placed."
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:pay_type)
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
