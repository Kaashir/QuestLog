class UserQuest < ApplicationRecord
  belongs_to :quest
  belongs_to :user
  has_one :hero_class, through: :quest, source: :hero_class # helps associate a hero_class with user_quests
  before_create :assign_next_position

  private

  def assign_next_position
    # Get the highest position currently used
    highest_position = user.user_quests.maximum(:position) || 0

    # Assign the next position
    self.position = highest_position + 1
  end

  # This method should return all quests for a specific class for a specific user using the hero_class association
  def quest_by_class(class_name)
    where(user: user).where(hero_class: { name: class_name })
  end
end
