class ChangeOrderAndNameDefaultToColumns < ActiveRecord::Migration[5.1]
  change_column_default :columns, :order, 0
  change_column_default :columns, :name, ""
end
