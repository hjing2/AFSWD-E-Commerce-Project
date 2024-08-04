class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)

    Rails.logger.debug "Initial products count: #{@products.count}"

    if params[:new_products] == "1"
      @products = @products.where("created_at >= ?", 3.days.ago)
      Rails.logger.debug "After new products filter: #{@products.count}"
    end

    if params[:recently_updated] == "1"
      @products = @products.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
      Rails.logger.debug "After recently updated filter: #{@products.count}"
    end

    if params[:on_sale] == "1"
      @products = @products.where(is_on_sale: true)
      Rails.logger.debug "After on sale filter: #{@products.count}"
    end

    Rails.logger.debug "Final products count: #{@products.count}"

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
