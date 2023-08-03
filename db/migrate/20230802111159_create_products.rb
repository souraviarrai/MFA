# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :attachment
      t.string :name
      t.text :description
      t.integer :price
      t.integer :quantity
      t.timestamps
    end
  end
end
