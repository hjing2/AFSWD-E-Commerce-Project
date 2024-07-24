class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def add_product
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart[product.id.to_s] = (@cart[product.id.to_s] || 0) + 1
    redirect_to cart_path, notice: "#{product.product_name} was added to your cart."
  end

  def remove_product
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart.delete(product.id.to_s)
    redirect_to cart_path, notice: "#{product.product_name} was removed from your cart."
  end
end
