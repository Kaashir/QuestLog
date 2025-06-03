class CreateCategoryTable < ActiveRecord::Migration[7.1]
  def change
    create_table :quest_categories do |t|
      t.string :name
      t.integer :category_xp
      t.string :class_type

      t.timestamps
    end
  end
end
