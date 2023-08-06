# frozen_string_literal: true

class Outlet < ApplicationRecord
  belongs_to :user
  has_many :outlet_product
  has_many :product, through: :outlet_product

  enum :status, {pending: 0, accepted: 1}
end
