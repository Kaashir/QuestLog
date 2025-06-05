class AddActiveColumnToUserClass < ActiveRecord::Migration[7.1]
  def change
    add_column :user_classes, :active, :boolean, default: false, null: false
  end
end
