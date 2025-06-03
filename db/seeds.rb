# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

Quest.create!([
  {
    title: "5K Run",
    description: "Run 5 kilometers without stopping.",
    xp_granted: 30,
    category: "Cardio",
    frequency: 2
  },
  {
    title: "Upper Body Blast",
    description: "Complete a workout focused on chest, back, and arms.",
    xp_granted: 35,
    category: "Upper Body",
    frequency: 2
  },
  {
    title: "Leg Day Warrior",
    description: "Do a lower body strength session (squats, lunges, deadlifts).",
    xp_granted: 35,
    category: "Lower Body",
    frequency: 1
  },
  {
    title: "Full Body Strength Circuit",
    description: "Complete a workout combining compound lifts and core.",
    xp_granted: 40,
    category: "Full Body",
    frequency: 1
  },
  {
    title: "Cardio Sprint Intervals",
    description: "Do 10 sets of 30s sprints with 1-min recovery.",
    xp_granted: 25,
    category: "Cardio",
    frequency: 2
  },
  {
    title: "Mobility Flow",
    description: "Spend 20 minutes doing mobility and dynamic stretching.",
    xp_granted: 15,
    category: "Mobility",
    frequency: 3
  },
  {
    title: "Cold Shower Challenge",
    description: "Take a 2-minute cold shower post-workout.",
    xp_granted: 10,
    category: "Challenge",
    frequency: 2
  },
  {
    title: "Burpee Burnout",
    description: "Do 100 burpees throughout the day.",
    xp_granted: 30,
    category: "Challenge",
    frequency: 1
  },
  {
    title: "Stair Climb Power",
    description: "Climb at least 30 floors this week.",
    xp_granted: 20,
    category: "Cardio",
    frequency: 1
  }
])
