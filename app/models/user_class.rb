class UserClass < ApplicationRecord
  belongs_to :user
  before_save :check_and_level_up

  def xp_needed_for_next_level
    level * 100
  end

  def xp_progress_percentage
    (xp.to_f / xp_needed_for_next_level * 100).round
  end

  private

  def check_and_level_up
    while xp >= xp_needed_for_next_level
      self.xp -= xp_needed_for_next_level
      self.level += 1
    end
  end
end
