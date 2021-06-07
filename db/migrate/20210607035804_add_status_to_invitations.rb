class AddStatusToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_column :invitations, :status, :string
  end
end
