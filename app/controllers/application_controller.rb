# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionDispatch::RequestCookieMethods

  def current_user
    User.find_by(auth_token: session[:user_auth_token])
  end
end
