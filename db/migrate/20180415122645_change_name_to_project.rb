class ChangeNameToProject < ActiveRecord::Migration[5.1]
  change_column_null    :projects, :name, false
  change_column_default :projects, :name, ''
end
