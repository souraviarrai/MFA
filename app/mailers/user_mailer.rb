# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'sourav@gmail.com'

  def welcome
    @user = params[:user]
    @url = 'http://localhost/3000'
    mail(to: @user.email, subject: 'welcome to MFA please signup')
  end
end
