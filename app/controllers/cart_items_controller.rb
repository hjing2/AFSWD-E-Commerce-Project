class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    current_cart[product.id.to_s] = (current_cart[product.id.to_s] || 0) + quantity
    redirect_to cart_path, notice: "#{product.product_name} was added to your cart."
  end

  def update
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    if quantity > 0
      current_cart[product.id.to_s] = quantity
    else
      current_cart.delete(product.id.to_s)
    end
    redirect_to cart_path, notice: "Cart was updated."
  end

  def destroy
    product = Product.find(params[:id])
    current_cart.delete(product.id.to_s)
    redirect_to cart_path, notice: "#{product.product_name} was removed from your cart."
  end

  private

  def current_cart
    session[:cart] ||= {}
  end
end
