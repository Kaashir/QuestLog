class UserClass < ApplicationRecord
  belongs_to :user
  before_save :check_and_level_up
  after_update_commit :broadcast_level_and_xp

  def xp_needed_for_next_level
    level * 100
  end

  def xp_progress_percentage
    (xp.to_f / xp_needed_for_next_level * 100).round
  end

  def active?
    active
  end

  private

  def check_and_level_up
    while xp >= xp_needed_for_next_level
      self.xp -= xp_needed_for_next_level
      self.level += 1
    end
  end

  def broadcast_level_and_xp
    broadcast_replace_to(
      "user_#{user_id}_level_xp",
      partial: "shared/level_xp",
      target: "level_xp",
      locals: { user_class: self }
    )
  end
end
