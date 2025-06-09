class RenameClassTableNameToHeroClass < ActiveRecord::Migration[7.1]
  def change
    rename_table :classes, :hero_classes
  end
end
