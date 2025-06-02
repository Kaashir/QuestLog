class RemoveCompletedFromQuests < ActiveRecord::Migration[7.1]
  def change
    remove_column :quests, :completed, :boolean
  end
end
