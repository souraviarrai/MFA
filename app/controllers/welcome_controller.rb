class WelcomeController < ApplicationController
  def index
    render status: :ok
  end
end