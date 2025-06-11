class CreateQuestEmbeddings < ActiveRecord::Migration[7.1]
  def change
    create_table :quest_embeddings do |t|
      t.references :user_quest, null: false, foreign_key: true
      t.column :embedding, :vector, limit: 1536
      t.timestamps
    end
  end
end
