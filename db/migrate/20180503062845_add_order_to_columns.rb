class AddOrderToColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :columns, :order, :integer, null: false
    add_index :columns, [:order, :project_id]
  end
end
