class AddPositionToUserQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :user_quests, :position, :integer
  end
end
