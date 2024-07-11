class HomeController < ApplicationController
  def index
    if params[:search].present?
      @products = Product.where("product_name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).per(6)
    else
      @products = Product.page(params[:page]).per(6)
    end
  end
end
