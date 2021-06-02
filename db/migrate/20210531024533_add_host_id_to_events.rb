class AddHostIdToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :host_id, :bigint
    add_foreign_key :events, :users, column: :host_id
  end
end
