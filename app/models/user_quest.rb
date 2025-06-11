class UserQuest < ApplicationRecord
  belongs_to :quest
  belongs_to :user
  has_one :hero_class, through: :quest, source: :hero_class # helps associate a hero_class with user_quests
  before_create :assign_next_position

  # This method should return all quests for a specific class for a specific user using the hero_class association
  def self.quest_by_class(class_name, user)
    joins(:hero_class)
      .where(hero_class: { name: class_name })
      .where(user: user)
  end

  has_neighbors :embedding
  after_create :set_embedding

  # Scope to get quests for a specific hero class and completion status
  scope :for_hero_class, lambda { |hero_class|
    joins(:quest)
      .where(quests: { quest_category: hero_class.quest_categories })
    }
    

  private

  def assign_next_position
    # Get the highest position currently used
    highest_position = user.user_quests.maximum(:position) || 0

    # Assign the next position
    self.position = highest_position + 1
  end

  def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: "Quest: #{quest.title}. Description: #{quest.description}. xp granted: #{quest.xp_granted}" \
               "Hero class: #{quest.quest_category.hero_class.name}. " \
               "User class: #{user.current_class.hero_class.name}. " \
      }
    )
    embedding = response['data'][0]['embedding']
    update(embedding: embedding)
  end
end
