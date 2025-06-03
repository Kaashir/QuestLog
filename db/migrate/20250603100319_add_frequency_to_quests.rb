class AddFrequencyToQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :frequency, :string
  end
end
