class Quest < ApplicationRecord
  #TODO: set current_user in correct controller
  attr_accessor :current_user

  has_neighbors :embedding
  after_create :set_embedding

  before_create :set_xp
  before_update :set_xp

  has_many :user_quests
  has_many :users, through: :user_quests
  has_many :user_classes, through: :users
  belongs_to :quest_category
  has_one :hero_class, through: :quest_category

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :quest_category, presence: true
  validates :frequency, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  # TODO: Uncomment when current_user is set in controller
  # validates :category_must_match_user_class


  private

  def set_xp
    self.xp_granted = quest_category.category_xp * frequency
  end

  def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: "Quest: #{title}. Description: #{description}. xp granted: #{xp_granted}. " \
               "Category: #{quest_category.name}" \
      }
    )
    embedding = response['data'][0]['embedding']
    update(embedding: embedding)
  end

  # Uncomment this method when current_user is set in the controller

  # def category_must_match_user_class
  #   if current_user.user_class.type != quest_category.type
  #     errors.add(:quest_category, "does not belong to your class type")
  #   end
  # end
end
