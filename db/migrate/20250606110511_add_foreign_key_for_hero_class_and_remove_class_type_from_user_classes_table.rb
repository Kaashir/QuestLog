class AddForeignKeyForHeroClassAndRemoveClassTypeFromUserClassesTable < ActiveRecord::Migration[7.1]
  def change
    add_column :user_classes, :hero_class_id, :bigint
    add_index :user_classes, :hero_class_id
    add_foreign_key :user_classes, :hero_classes, column: :hero_class_id, on_delete: :cascade
    remove_column :user_classes, :class_type, :string
  end
end
