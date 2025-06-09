namespace :user_quests do
  desc "Assign positions to existing quests that don't have positions"
  task assign_positions: :environment do
    User.find_each do |user|
      user.user_quests.where(position: nil).each do |quest|
        taken_positions = user.user_quests.where.not(id: quest.id).pluck(:position).compact
        available_positions = (1..12).to_a - taken_positions

        quest.update(position: available_positions.any? ? available_positions.sample : rand(1..12))
      end
    end
  end
end
