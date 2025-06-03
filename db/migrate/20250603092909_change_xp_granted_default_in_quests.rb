class ChangeXpGrantedDefaultInQuests < ActiveRecord::Migration[7.1]
  def change
    change_column_default :quests, :xp_granted, 0
  end
end
