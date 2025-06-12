User.destroy_all
puts "Deleted all users."

users = [
  { username: "kaashir", first_name: 'Mrinal', last_name: 'Verma', email: 'mrinalverma1993@gmail.com', password: '123123', password_confirmation: '123123', address: '123 Peace Palace Street, The Hague, Netherlands', date_birth: "22/07/1993"},
  { username: "fratboi12", first_name: 'Thomas', last_name: 'Bruins', email: 'thomas.bruins12@gmail.com', password: '123123', password_confirmation: '123123', address: '456 Dam Square, Amsterdam, Netherlands', date_birth: "16/06/2006"},
  { username: "travelingdev", first_name: 'Carlijn', last_name: 'Driessen', email: 'carlijndriessen.dev@gmail.com', password: '123123', password_confirmation: '123123', address: '789 Maastricht Central, Limburg, Netherlands', date_birth: "7/11/1994"},
  { username: "dawikir", first_name: 'Daniel', last_name: 'Suarez', email: 'ndanielmnv@gmail.com', password: '123123', password_confirmation: '123123', address: '321 Erasmus Bridge Road, Rotterdam, Netherlands', date_birth: "23/07/1990"}
]

# Create users
users.each do |user_data|
  User.create!(user_data)
  puts "Created user: #{user_data[:first_name]} with ID: #{User.last.id}"
end

puts "#{User.all.count} users created."

UserClass.destroy_all
puts "Deleted all user classes."

HeroClass.destroy_all
puts "Deleted all hero classes."

# Create hero classes
hero_classes = [
  { name: 'Warrior', description: 'A strong and brave fighter, skilled in combat.' },
  { name: 'Healer', description: 'A compassionate individual, adept at healing and support.' },
  { name: 'Monk', description: 'A wise and disciplined practitioner, focused on inner peace and balance.' }
]

hero_classes.each do |klass_data|
  hero_class = HeroClass.create!(klass_data)
  puts "Created hero class: #{hero_class.name}"
end

# Store hero classes for reference
warrior = HeroClass.find_by(name: 'Warrior')
healer = HeroClass.find_by(name: 'Healer')
monk = HeroClass.find_by(name: 'Monk')

# Create user classes
user_classes = [
  { hero_class: warrior, xp: 0, level: 1 },
  { hero_class: healer, xp: 0, level: 1 },
  { hero_class: warrior, xp: 0, level: 1 },
  { hero_class: monk, xp: 0, level: 1 }
]

user_id = User.first.id # Start from the first user ID
user_classes.each do |class_data|
  user_class = UserClass.new(class_data)
  user_class.user = User.find(user_id)
  user_id += 1
  user_class.active = true
  user_class.save!
  puts "Created user class: #{user_class.hero_class.name} for user #{user_class.user.username}"
end

puts "#{UserClass.all.count} user classes created."

QuestCategory.destroy_all
puts "Deleted all quest categories."

# Create quest categories

# Warrior
warrior_categories = [
  { name: 'Gym', category_xp: 20, hero_class: warrior, icon: "Warrior_icons/Gym-Icon.png" },
  { name: 'Running', category_xp: 15, hero_class: warrior, icon: "Warrior_icons/Running-Icon.png" },
  { name: 'Walking', category_xp: 10, hero_class: warrior, icon: "Warrior_icons/Walking-Icon.png" },
  { name: 'Martial Arts', category_xp: 22, hero_class: warrior, icon: "Warrior_icons/Marital-Arts-Icon.png" },
  { name: 'Swimming', category_xp: 18, hero_class: warrior, icon: "Warrior_icons/Swimming-Icon.png" },
  { name: 'Cycling', category_xp: 16, hero_class: warrior, icon: "Warrior_icons/Cycling-Icon.png" },
  { name: 'Hiking', category_xp: 17, hero_class: warrior, icon: "Warrior_icons/Hiking-Icon.png" },
  { name: 'Calisthenics', category_xp: 19, hero_class: warrior, icon: "Warrior_icons/Calisthenics-Icon.png" },
  { name: 'Recovery', category_xp: 14, hero_class: warrior, icon: "Warrior_icons/Stretching-Icon.png" }
]

# Healer
healer_categories = [
  { name: 'Journaling', category_xp: 10, hero_class: healer, icon: "Healer_icons/Journalling-Icon.png" },
  { name: 'Gratitude Practice', category_xp: 12, hero_class: healer, icon: "Healer_icons/Gratitude-Practice-Icon.png" },
  { name: 'Emotional Check-in', category_xp: 8, hero_class: healer, icon: "Healer_icons/Emotional-Check-in-Icon.png" },
  { name: 'Therapy Session', category_xp: 25, hero_class: healer, icon: "Healer_icons/Therapy-Session-Icon.png" },
  { name: 'Community Volunteering', category_xp: 20, hero_class: healer, icon: "Healer_icons/Volunteering-Icon.png" },
  { name: 'Sleep Hygiene', category_xp: 12, hero_class: healer, icon: "Healer_icons/Sleep-Hygiene-Icon.png" },
  { name: 'Mindful Eating', category_xp: 15, hero_class: healer, icon: "Healer_icons/Mindful-Eating-Icon.png" },
  { name: 'Digital Detox', category_xp: 18, hero_class: healer, icon: "Healer_icons/Digital-Detox-Icon.png" }
]

# Monk
monk_categories = [
  { name: 'Meditation', category_xp: 12, hero_class: monk, icon: "Monk_icons/Meditation-Icon.png" },
  { name: 'Yoga', category_xp: 14, hero_class: monk, icon: "Monk_icons/Yoga-Icon.png" },
  { name: 'Breathwork', category_xp: 10, hero_class: monk, icon: "Monk_icons/Breathwork-Icon.png" },
  { name: 'Fasting', category_xp: 22, hero_class: monk, icon: "Monk_icons/Fasting-Icon.png" },
  { name: 'Cold Exposure', category_xp: 18, hero_class: monk, icon: "Monk_icons/Cold-Exposure-Icon.png" },
  { name: 'Silence Practice', category_xp: 8, hero_class: monk, icon: "Monk_icons/Silence-Practice-Icon.png" },
  { name: 'Reading Sacred Texts', category_xp: 14, hero_class: monk, icon: "Monk_icons/Reading-Sacred-Texts-Icon.png" }
]

all_categories = warrior_categories + healer_categories + monk_categories

all_categories.each do |category_data|
  category = QuestCategory.create!(category_data)
  puts "Created quest category: #{category.name} with XP: #{category.category_xp}"
end
puts "#{QuestCategory.all.count} quest categories created."

# delete all quests
Quest.destroy_all
puts "Deleted all quests."

# Adding pre-made quests

# Warrior quests
warrior_quests = [
  { title: 'Go to the Gym', description: 'Train your body within the iron halls — complete a full gym session.', frequency: 3, quest_category: QuestCategory.find_by(name: 'Gym') },
  { title: 'Run 5km', description: 'Lace up and run 5km — your endurance grows with each stride.', frequency: 2, quest_category: QuestCategory.find_by(name: 'Running') },
  { title: 'Walk 10,000 Steps', description: 'Set forth on a daily journey of 10,000 steps.', frequency: 5, quest_category: QuestCategory.find_by(name: 'Walking') },
  { title: 'Swim for 30 Minutes', description: 'Glide through the waters for a 30-minute swim quest.', frequency: 2, quest_category: QuestCategory.find_by(name: 'Swimming') },
  { title: 'Martial Arts Training', description: 'Sharpen your combat skills — complete a focused martial arts session.', frequency: 3, quest_category: QuestCategory.find_by(name: 'Martial Arts') },
  { title: 'Complete a Hike', description: 'Conquer the path ahead — complete a hike over 5km.', frequency: 1, quest_category: QuestCategory.find_by(name: 'Hiking') },
  { title: 'Do a Calisthenics Circuit', description: 'Strengthen your body with a full calisthenics routine.', frequency: 3, quest_category: QuestCategory.find_by(name: 'Calisthenics') },
  { title: 'Cycle for 20km', description: 'Ride forth on a 20km cycling journey.', frequency: 2, quest_category: QuestCategory.find_by(name: 'Cycling') },
  { title: 'Stretch & Recover', description: 'Honor your body with a focused stretching session.', frequency: 3, quest_category: QuestCategory.find_by(name: 'Recovery') }
]

# HealerQuests
healer_quests = [
  { title: 'Journal Entry', description: 'Record your thoughts — each entry brings clarity and healing.', frequency: 5, quest_category: QuestCategory.find_by(name: 'Journaling') },
  { title: 'Volunteer Time', description: 'Give an hour of service to others — a quest of kindness.', frequency: 1, quest_category: QuestCategory.find_by(name: 'Community Volunteering') },
  { title: 'Emotional Check-in', description: 'Pause to check in with your feelings — wisdom lies within.', frequency: 4, quest_category: QuestCategory.find_by(name: 'Emotional Check-in') },
  { title: 'Attend Therapy', description: 'Attend a therapy or counseling session — courage is healing.', frequency: 1, quest_category: QuestCategory.find_by(name: 'Therapy Session') },
  { title: 'Write 5 Gratitudes', description: 'Log three things you are grateful for — a ritual of light.', frequency: 5, quest_category: QuestCategory.find_by(name: 'Gratitude Practice') },
  { title: 'Digital Detox Day', description: 'Embark on a one-day digital detox — reclaim your presence.', frequency: 1, quest_category: QuestCategory.find_by(name: 'Digital Detox') },
  { title: 'Mindful Eating', description: 'Eat one meal with full awareness and gratitude.', frequency: 5, quest_category: QuestCategory.find_by(name: 'Mindful Eating') },
  { title: 'Sleep Hygiene Ritual', description: 'Complete your night ritual for deep, restful sleep.', frequency: 4, quest_category: QuestCategory.find_by(name: 'Sleep Hygiene') },
]

# Monk Quests
monk_quests = [
  { title: 'Meditate for 20 Minutes', description: 'Sit in stillness for 20 minutes — clarity awaits within.', frequency: 5, quest_category: QuestCategory.find_by(name: 'Meditation') },
  { title: 'Yoga Flow', description: 'Complete a yoga flow — honor the body, calm the mind.', frequency: 4, quest_category: QuestCategory.find_by(name: 'Yoga') },
  { title: 'Breathwork Session', description: 'Practice 3 rounds of breathwork — the breath is your ally.', frequency: 5, quest_category: QuestCategory.find_by(name: 'Breathwork') },
  { title: 'Fasting Practice', description: 'Complete an intermittent fasting window today.', frequency: 2, quest_category: QuestCategory.find_by(name: 'Fasting') },
  { title: 'Cold Exposure', description: 'Embrace the cold — complete a cold shower or ice bath.', frequency: 3, quest_category: QuestCategory.find_by(name: 'Cold Exposure') },
  { title: '1 Hour of Silence', description: 'Spend one hour in intentional silence — wisdom arises in stillness.', frequency: 2, quest_category: QuestCategory.find_by(name: 'Silence Practice') },
  { title: 'Read Wisdom Texts', description: 'Read from sacred or philosophical texts to expand your mind.', frequency: 4, quest_category: QuestCategory.find_by(name: 'Reading Sacred Texts') },
  { title: 'Walking Meditation', description: 'Complete a 15-minute walking meditation — move with presence.', frequency: 5, quest_category: QuestCategory.find_by(name: 'Meditation') },
]

all_quests = warrior_quests + healer_quests + monk_quests

# Create quests - with frequency set to 3 for demo purposes and xp set manually based on category and frequency
all_quests.each do |quest_data|
  quest = Quest.create!(quest_data)
  puts "Created quest: #{quest.title} with XP: #{quest.xp_granted}"
end

puts "#{Quest.all.count} quests created."

UserQuest.destroy_all
puts "Deleted all user quests."

# Assign Warrior quests to Warrior user classes
UserClass.where(hero_class: HeroClass.find_by(name: 'Warrior')).each do |user_class|
  # Get all available warrior quests
  available_quests = Quest.where(quest_category: QuestCategory.where(hero_class: user_class.hero_class))
  # Take 5 random unique quests
  available_quests.sample(5).each do |quest|
    assigned_quest = UserQuest.create!(
      user: user_class.user,
      quest: quest,
      completed: false,
      completed_frequency: 0
    )
    puts "Assigned Warrior quest to User: #{assigned_quest.user.first_name} - Quest: #{assigned_quest.quest.title}"
  end
end

# Assign Healer quests to Healer user classes
UserClass.where(hero_class: HeroClass.find_by(name: 'Healer')).each do |user_class|
  # Get all available healer quests
  available_quests = Quest.where(quest_category: QuestCategory.where(hero_class: user_class.hero_class))
  # Take 5 random unique quests
  available_quests.sample(5).each do |quest|
    assigned_quest = UserQuest.create!(
      user: user_class.user,
      quest: quest,
      completed: false,
      completed_frequency: 0
    )
    puts "Assigned Healer quest to User: #{assigned_quest.user.first_name} - Quest: #{assigned_quest.quest.title}"
  end
end

# Assign Monk quests to Monk user classes
UserClass.where(hero_class: HeroClass.find_by(name: 'Monk')).each do |user_class|
  # Get all available monk quests
  available_quests = Quest.where(quest_category: QuestCategory.where(hero_class: user_class.hero_class))
  # Take 5 random unique quests
  available_quests.sample(5).each do |quest|
    assigned_quest = UserQuest.create!(
      user: user_class.user,
      quest: quest,
      completed: false,
      completed_frequency: 0
    )
    puts "Assigned Monk quest to User: #{assigned_quest.user.first_name} - Quest: #{assigned_quest.quest.title}"
  end
end

puts "#{UserQuest.all.count} user-quests created."
