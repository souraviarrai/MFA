# frozen_string_literal: true

# app/mailers/user_mailer.rb

class UserMailer < ApplicationMailer
  default from: 'souravdungbungrai@gmail.com'
  def invite_email(email, name)
    @name = name
    mail(to: email, subject: "Dear #{@name}, Invitation to Join Our Platform(MFA)")
  end
end

