class CreateQuestCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :quest_categories do |t|
      t.string :name, null: false
      t.integer :category_xp, null: false, default: 0
      t.string :class_type, null: false
      
      t.timestamps
    end
  end
end
