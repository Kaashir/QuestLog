class UserQuest < ApplicationRecord
  belongs_to :quest
  belongs_to :user
  before_create :assign_random_position

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
end
