class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    if current_user.current_address
      @order.assign_attributes(current_user.current_address.attributes.slice("address_line", "city", "province_id", "postal_code", "country"))
    end
  end

  def confirm
    @order = Order.new(order_params)
    session[:order_params] = order_params
    save_order_items_to_temp_order
    @order.calculate_total_price
    @cart = current_cart
    render :confirm
  end

  def create
    order_params = session[:order_params]
    if order_params.nil?
      flash[:alert] = "Order parameters are missing."
      redirect_to new_order_path and return
    end

    @order = current_user.orders.build(order_params)
    @order.province = Province.find(order_params["province_id"])
    save_order_items(@order)
    @order.calculate_total_price

    if @order.save
      clear_cart
      session.delete(:order_params)
      @order.update(is_paid: true)
      redirect_to success_order_path(@order), notice: "Order successfully placed."
    else
      render :confirm
    end
  end

  def clear_cart
    session[:cart] = {}
  end

  def success
    @order = Order.find(params[:id])
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
  end

  def index
    @orders = current_user.orders
  end

  private

  def order_params
    params.require(:order).permit(:pay_type, :address_line, :city, :province_id, :postal_code, :country, order_items_attributes: [:id, :product_id, :quantity, :_destroy])
  end

  def save_order_items_to_temp_order
    @cart = current_cart
    @cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: quantity, order_items_total_price: product.price * quantity)
    end
  end

  def save_order_items(order)
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      order.order_items.build(product: product, quantity: quantity, order_items_total_price: product.price * quantity)
    end
  end

  def current_cart
    session[:cart] ||= {}
  end
end
