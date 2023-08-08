# frozen_string_literal: true

class CreateOutletProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :outlet_products do |t|
      t.belongs_to :outlet, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
