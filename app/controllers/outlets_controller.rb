# frozen_string_literal: true

class OutletsController < ApplicationController
  def index
    @active_outlet = Outlet.where(status: 'accepted')
    render json: @active_outlet
  end

  def show
    @outlet = Outlet.find(params[:id])
    if @outlet.status == 'pending'
      render body: "outlet #{@outlet.id} is in pending", status: 404
    else
      render json: @outlet
    end
  end

  def pending
    @inactive_outlets = Outlet.where(status: 'pending')
    render json: @inactive_outlets
  end

  def pending_show
    inactive_outlet = Outlet.find(params[:id])
    if inactive_outlet
      if inactive_outlet.status == 'pending'
        render json: inactive_outlet
      else
        render :body => 'The outlet is already accepted'
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: 'Not Found', status: :not_found
  end

  def accept
    @inactive_outlet = Outlet.find(params[:id])
    return unless @inactive_outlet.status == 'pending'

    @inactive_outlet.accepted!
    render json: @inactive_outlet, status: 200
  end

  def reject
    @inactive_outlet = Outlet.find(params[:id])
    if @inactive_outlet.status == 'pending'
      @inactive_outlet.destroy
      render body: 'The outlet has been rejected and deleted.', status: 200
    else
      render body: "The outlet cannot be rejected and deleted as it's not in the pending request", status: 422
    end
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
