class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :name, null: false, default: ""
      t.datetime :deadline
      t.references :project, foreign_key: true, null: false
      t.references :column, foreign_key: true, null: false
      t.integer :assignee_id
      t.timestamps
    end

    add_index :cards, [:name, :project_id], unique: true
  end
end
