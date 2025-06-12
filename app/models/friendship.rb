class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validate :cannot_friend_self, :not_already_friends

  private

  def cannot_friend_self
    errors.add(:friend, "cannot be the same as the user") if user_id == friend_id
  end

  def not_already_friends
    if Friendship.exists?(user_id: user_id, friend_id: friend_id) || Friendship.exists?(user_id: friend_id, friend_id: user_id)
      errors.add(:friend, "already added")
    end
  end
end
