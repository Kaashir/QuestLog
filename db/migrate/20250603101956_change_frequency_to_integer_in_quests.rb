class ChangeFrequencyToIntegerInQuests < ActiveRecord::Migration[7.1]
  def change
    change_column :quests, :frequency, :integer, using: 'frequency::integer'
  end
end
