class AddEmbeddingToUserQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :user_quests, :embedding, :vector, limit: 1536
  end
end
