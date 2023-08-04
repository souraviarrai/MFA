# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :avatar
  has_many :outlet_product
  has_many :outlet, through: :outlet_product

  validates :name, presence: true
  validates :description, presence: true


end
