class ChangeXpAndLevelinUserClassTable < ActiveRecord::Migration[7.1]
  def change
    change_column :user_classes, :xp, :integer, default: 0, null: false
    change_column :user_classes, :level, :integer, default: 1, null: false
  end
end
