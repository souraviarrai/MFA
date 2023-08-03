# frozen_string_literal: true

class OutletProduct < ApplicationRecord
  belongs_to :outlet
  belongs_to :product
end
