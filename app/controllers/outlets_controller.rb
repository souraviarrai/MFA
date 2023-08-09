# frozen_string_literal: true

class OutletsController < ApplicationController
  require_relative '../services/outlet_index'

  REQUEST = ['accept','reject']
  def index
    if current_user == 'admin'
      result_index = ::Services::OutletIndex.new(params: { status: params[:status] }).call

      render json: result_index[:json], status: result_index[:status]
    else

      render body: 'No content to show', status: 401
    end
  end

  def show
    @outlet = Outlet.find(params[:id])
    if @outlet
      if @outlet.status == 'pending'
        render body: "outlet #{@outlet.name} is pending", status: 404
      else
        render json: @outlet
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: 'Not found', status: 404
  end

  # def pending
  #   if params[:id].present?
  #     inactive_outlet = Outlet.find(params[:id])
  #     if inactive_outlet.status == 'pending'
  #       render json: inactive_outlet, status: 200
  #       if params[:request] == 'accept'
  #         inactive_outlet.accepted!
  #         render json: inactive_outlet, status: 200
  #       elsif params[:request] == 'reject'
  #         inactive_outlet.destroy
  #         render json: "The outle has been rejected and deleted", status: 200
  #       end
  #     else
  #       render json: 'The outlet is already accepted', status: 200
  #     end
  #   else
  #
  #   end
  # rescue ActiveRecord::RecordNotFound => e
  #   render json: "record with the id #{params[:id]} not found"
  # end


  def accept
    @inactive_outlet = Outlet.find(params[:id])
    return unless @inactive_outlet.status == 'pending'
    @inactive_outlet.accepted!
    render json: @inactive_outlet, status: 200
  rescue ActiveRecord::RecordNotFound => e
    render json: "record with the particular id  not found"
  end

  def reject
    @inactive_outlet = Outlet.find(params[:id])
    if @inactive_outlet.status == 'pending'
      @inactive_outlet.destroy
      render body: 'The outlet has been rejected and deleted.', status: 200
    else
      render body: "The outlet cannot be rejected and deleted as it's not in the pending request", status: 422
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: "record with the particular id  not found"
  end

  def inivte_outlet_admins
    if current_user.role == 'admin'
      @new_user = email_params
      UserMailer.invite_email(@new_user[:email], @new_user[:name]).deliver_now
      render body: 'Invitation email sent successfully', status: :created
    else
      render body: 'you can not invite as you are not the admin', status: 422
    end
  end

  def new
    @outlet = Outlet.new
  end

  def create
    @outlet = Outlet.new(outlet_params)
    return unless current_user.role == 'admin' || current_user.role == 'oadmin'

    if !@outlet.valid?
      error_messages = @outlet.error.full_messages
      render json: error_messages, status: 422
    else
      @outlet.save
      render json: @outlet, status: :ok
    end
  end

  def destroy
    @outlet = Outlet.find(params[:id])
    @outlet.destroy

    render status: :ok
  end

  private

  def outlet_params
    params.require(:outlet).permit(:name, :user_id, :location)
  end

  def email_params
    params.require(:outlet).permit(:email, :name)
  end
end
