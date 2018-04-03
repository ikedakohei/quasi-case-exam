class RemoveSnsImageFormUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :sns_image
  end

  def down
    add_column :users, :sns_image, :string
  end
end
