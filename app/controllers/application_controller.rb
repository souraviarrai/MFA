# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionDispatch::Cookies::ChainedCookieJars

  # def is_admin()
  #   if @user.status == "admin"
  #     retrun true
  #   end
  # end
  # def is_oadmin()
  #   if @user.status == "oadmin"
  #     return true
  #   end
  # end
  #
  # def is_user()
  #   if @user.status == "user"
  #     retrun true
  #   end
  # end
  def current_user
    User.find_by(auth_token: session[:user_auth_token])
  end


end
