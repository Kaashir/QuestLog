class ChangeUserClassesActiveDefaultToTrue < ActiveRecord::Migration[7.1]
  def change
    change_column_default :user_classes, :active, from: false, to: true
  end
end
