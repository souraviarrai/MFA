# frozen_string_literal: true

module Services
  class OrderCreator
    attr_accessor :params

    def initialize(params)
      @params = params
    end

    def call; end
  end
end
