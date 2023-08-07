class AddStatusToOutlet < ActiveRecord::Migration[7.0]
  def change
    add_column :outlets, :status,:integer , default: 0
  end
end
