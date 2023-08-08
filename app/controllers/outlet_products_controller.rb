# frozen_string_literal: true

class OutletProductsController < ApplicationController
  def index
    outlet = Outlet.find(params[:id].to_i)
    op = OutletProduct.where(outlet_id: outlet)
    @products = Product.where(id: op.pluck(:product_id))
    @product_list = @products.map do |product|
      {
        id: product.id,
        attachment: product.attachment,
        name: product.name,
        description: product.description,
        price: product.price,
        quantity: product.outlet_product.find_by(outlet: outlet).quantity,
        created_at: product.created_at,
        updated_at: product.updated_at
      }
    end

    render json: @product_list, status: 200

    # @outlet_product = Product.find(@products).outlet_product.find_by(outlet: outlet).quantity
    # @outlet_product_quantity = @products.map do |product|
    #   product.outlet_product.find_by(outlet: outlet).quantity
    # end
  end
end
