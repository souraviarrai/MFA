# frozen_string_literal: true

class OutletsController < ApplicationController
  def index
    @outlets = Outlet.all
    render json: @outlets
  end

  def show
    @outlet = Outlet.find(params[:id])
    render json: @outlet
  end
  def new
    @outlet = Outlet.new
  end
  def create
    @outlet = Outlet.new(outlet_params)

    if @outlet.save
      render json: @outlet, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    @outlet = Outlet.find(params[:id])
    @outlet.destroy

    render status: :ok
  end

  private

  def outlet_params
    params.require(:outlet).permit(:name, :user_id)
  end
end
