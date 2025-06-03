class AddColumntoUserQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :user_quests, :completed_frequency, :integer, default: 0
  end
end
