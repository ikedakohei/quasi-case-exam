class AddAcceptToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :accept, :boolean, default: false
  end
end
