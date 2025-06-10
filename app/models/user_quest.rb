class UserQuest < ApplicationRecord
  belongs_to :quest
  belongs_to :user
  has_one :hero_class, through: :quest, source: :hero_class # helps associate a hero_class with user_quests
  before_create :assign_random_position

  has_neighbors :embedding
  after_create :set_embedding

  private

  def assign_random_position
    taken_positions = user.user_quests.pluck(:position).compact
    available_positions = (1..20).to_a - taken_positions

    if available_positions.any?
      self.position = available_positions.sample
    else
      # If all positions are taken, assign a random position from 1-20
      self.position = rand(1..20)
    end
  end

  # This method should return all quests for a specific class for a specific user using the hero_class association
  def quest_by_class(class_name)
    where(user: user).where(hero_class: { name: class_name })
  end

  def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: "Quest: #{quest.title}. Description: #{quest.description}. xp granted: #{quest.xp_granted}" \
               "Hero class: #{quest.quest_category.hero_class.name}. " \
               "User class: #{user.user_class.name}. " \
      }
    )
    embedding = response['data'][0]['embedding']
    update(embedding: embedding)
  end
end
