# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    binding.pry
    @products = Product.all
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def new
    @product = Product.new
  end

  def create
    binding.pry
    @product = Product.new(product_params)
    if current_user.role == 'admin'
      if !@product.valid?
        error_messages = @product.errors.full_messages
        render json: error_messages, status: 422
      else
        @product.save
        render json: @product, status: :ok
      end

    else
      render status: :unauthorized
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    render status: :ok
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end
end
