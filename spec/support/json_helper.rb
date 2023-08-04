# frozen_string_literal: true

module JsonHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def login(user)
    post '/signin', params: { user: { email: user.email, password: user.password} }
  end
end
