class RemoveClassTypeFromQuestCategoriesAndAddForeignKeyToHeroClasses < ActiveRecord::Migration[7.1]
  def change
    remove_column :quest_categories, :class_type, :string
    add_reference :quest_categories, :hero_class, null: false, foreign_key: true
  end
end
