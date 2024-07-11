class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(10)

    if params[:on_sale].present?
      @products = @products.where(is_on_sale: true).per(10)
    end

    if params[:is_new].present?
      @products = @products.where(is_new: true).per(10)
    end

    if params[:is_recently_updated].present?
      @products = @products.where(is_recently_updated: true).per(10)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
