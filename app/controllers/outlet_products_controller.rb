# frozen_string_literal: true

class OutletProductsController < ApplicationController
  def index
    @ops = OutletProduct.all
    render json: @ops
  end
  def show
    @op = Outlet.find(params[:id])
    render json: @op
  end
end
