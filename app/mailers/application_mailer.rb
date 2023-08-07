# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'sourav@gmail.com'
  layout 'mailer'
end
