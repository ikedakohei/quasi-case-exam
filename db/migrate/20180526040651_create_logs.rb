class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string :content, null: false, default: ""
      t.string :image, null: false, default: ""
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
  end
end
