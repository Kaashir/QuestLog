class CreateUserQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :user_quests do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
