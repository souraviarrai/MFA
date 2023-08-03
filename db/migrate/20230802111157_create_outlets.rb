# frozen_string_literal: true

class CreateOutlets < ActiveRecord::Migration[7.0]
  def change
    create_table :outlets do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
