class AddSnsImageToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sns_image, :string
  end
end
