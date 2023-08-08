# frozen_string_literal: true

# require '../services/order_creator'
class OrdersController < ApplicationController
  def index
    orders = Order.all
    render json: orders, status: 200
  end

  def create
    # ::Services::OrderCreator.new(params: order_params.to_h).call
    order = Order.new(order_params)
    if order.valid?
      outlet = Outlet.find(order_params[:outlet_id].to_i)
      op = OutletProduct.where(outlet_id: outlet, product_id: order_params[:product_id])
      if op
        product_quantity = op.first.quantity
        updated_quantity = product_quantity - order_params[:quantity].to_i
        if updated_quantity >= 0
          op.update(quantity: updated_quantity)
          order.save
          render :body => order[:order], status => order[:status]
        else
          render body: 'not enough quantity for order', status: 422
        end
      else
        render body: 'No particular product is there', status: 422
      end
      # product_quantity = op.find_by(product_id: order_params[:product_id]).quantity
      # update_quantity = product_quantity - order_params[:product_quantity].to_i
      # update_quantity.save
    else
      render body: 'An error is there, please oreder once more', status: 422
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :product_id, :outlet_id, :quantity)
  end
end
