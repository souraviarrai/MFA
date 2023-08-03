# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      session[:user_auth_token] = user.auth_token

    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
