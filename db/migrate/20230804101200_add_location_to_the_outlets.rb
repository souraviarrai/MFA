# frozen_string_literal: true

class AddLocationToTheOutlets < ActiveRecord::Migration[7.0]
  def change
    add_column :outlets, :location, :string
  end
end
