class ChangeColumnToInvitations < ActiveRecord::Migration[5.1]
  def change
    change_column_null :invitations, :user_id, false
    change_column_null :invitations, :project_id, false
  end
end
