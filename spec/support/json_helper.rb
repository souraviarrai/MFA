# frozen_string_literal: true

module JsonHelper
  def json
    JSON.parse(response.body)
  end

  def login(user)
    binding.pry
    post '/signin', params: { user: { email: user.email, password: user.password } }
  end
end
