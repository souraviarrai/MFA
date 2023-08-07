# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    render status: :ok
  end
end
