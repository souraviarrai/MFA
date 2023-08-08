# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :outlet
  belongs_to :product
end
