# frozen_string_literal: true

class Outlet < ApplicationRecord
  belongs_to :user
  has_many :outlet_products
  has_many :products, through: :outlet_products

  enum :status, { pending: 0, accepted: 1 }
end
