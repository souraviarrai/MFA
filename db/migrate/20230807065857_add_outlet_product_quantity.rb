# frozen_string_literal: true

class AddOutletProductQuantity < ActiveRecord::Migration[7.0]
  def change
    add_column :outlet_products, :quantity, :integer
  end
end
