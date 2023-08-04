# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      session[:user_auth_token] = user.auth_token
      render :ok
    else
      # render :unprocessable_entity
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end
  def signin
    @user = User.find_by(email: user_params2[:email])
    if @user && @user.password == user_params2[:password]
      session[:user_auth_token] = @user.auth_token
      render status: :ok
    else
      render status: :unauthorized
    end
  end
  def logout
    session[:user_auth_token] = nil
    render status: :no_content
  end

  private

  def user_params2
    params.require(:user).permit(:email,:password)
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :status)
  end
end
