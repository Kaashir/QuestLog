class AddColumnIcontoQuestCategoryTable < ActiveRecord::Migration[7.1]
  def change
    add_column :quest_categories, :icon, :string
  end
end
