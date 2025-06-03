class Quest < ApplicationRecord
  #TODO: set current_user in correct controller
  attr_accessor :current_user

  before_create :set_xp
  before_update :set_xp

  has_many :user_quests
  has_many :users, through: :user_quests
  has_many :user_classes, through: :users
  belongs_to :quest_category


  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :category, presence: true
  validates :frequency, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates category_must_match_user_class

  private

  def set_xp
    self.xp_granted = quest_category.category_xp * frequency
  end

  def category_must_match_user_class
    if current_user.user_class.type != quest_category.type
      errors.add(:quest_category, "does not belong to your class type")
    end
  end


end
