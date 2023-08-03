# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :product, index: true, foreign_key: true, null: false
      t.belongs_to :outlet, index: true, foreign_key: true, null: false
      t.integer :quantity
      t.timestamps
    end
  end
end
