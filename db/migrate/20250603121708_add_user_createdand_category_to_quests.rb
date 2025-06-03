class AddUserCreatedandCategoryToQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :user_created, :boolean, default: false
    add_reference :quests, :quest_category, foreign_key: true
    remove_column :quests, :category, :string
  end
end
