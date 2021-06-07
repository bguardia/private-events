class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.bigint :sender_id
      t.bigint :invitee_id
      t.bigint :event_id

      t.text :body

      t.timestamps
    end

    add_foreign_key :invitations, :events, column: :event_id
    add_foreign_key :invitations, :users, column: :sender_id
    add_foreign_key :invitations, :users, column: :invitee_id
  end
end
