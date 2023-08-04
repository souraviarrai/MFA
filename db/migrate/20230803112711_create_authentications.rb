class CreateAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :authentications do |t|

      t.timestamps
    end
  end
end
