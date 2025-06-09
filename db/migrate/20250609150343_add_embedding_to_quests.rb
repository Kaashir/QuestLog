class AddEmbeddingToQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :embedding, :vector, limit: 1536
  end
end
