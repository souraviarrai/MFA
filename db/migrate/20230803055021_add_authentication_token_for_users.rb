# frozen_string_literal: true

class AddAuthenticationTokenForUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :auth_token, :string
  end
end
