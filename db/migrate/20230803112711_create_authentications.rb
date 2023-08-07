# frozen_string_literal: true

class CreateAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :authentications, &:timestamps
  end
end
