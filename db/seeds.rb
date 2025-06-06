

User.destroy_all
puts "Deleted all users."

users = [
  { username: "kaashir", first_name: 'Mrinal', last_name: 'Verma', email: 'mrinalverma1993@gmail.com', password: '123123', address: 'The Hague', date_birth: "22/07/1993"},
  { username: "fratboi12", first_name: 'Thomas', last_name: 'Bruins', email: 'thomas.bruins12@gmail.com', password: '123123', address: 'Amsterdam', date_birth: "16/06/2006"},
  { username: "travelingdev", first_name: 'Carlijn', last_name: 'Driessen', email: 'carlijndriessen.dev@gmail.com', password: '123123', address: 'Limburg', date_birth: "7/11/1994"},
  { username: "dawikir", first_name: 'Daniel', last_name: 'Suarez', email: 'ndanielmnv@gmail.com', password: '123123', address: 'Rotterdam', date_birth: "23/07/1990"}
]

# Create users
users.each do |user_data|
  User.create!(user_data)
  puts "Created user: #{user_data[:first_name]} with ID: #{User.last.id}"
end

puts "#{User.all.count} users created."

UserClass.destroy_all
puts "Deleted all user classes."

# Create hero classes
hero_classes = [
  { name: 'Warrior', description: 'A strong and brave fighter, skilled in combat.' },
  { name: 'Healer', description: 'A compassionate individual, adept at healing and support.' },
  { name: 'Monk', description: 'A wise and disciplined practitioner, focused on inner peace and balance.' }
]

hero_classes.each do |class_data|
  hero_class = HeroClass.create!(class_data)
  puts "Created hero class: #{hero_class.name}"
end

# Create user classes
user_classes = [
  { hero_class_id: 1, xp: 0, level: 1 },
  { hero_class_id: 2, xp: 0, level: 1 },
  { hero_class_id: 1, xp: 0, level: 1 },
  { hero_class_id: 3, xp: 0, level: 1 }
]

user_id = User.first.id # Start from the first user ID
user_classes.each do |class_data|
  user_class = UserClass.new(class_data)
  user_class.user = User.find(user_id)
  user_id += 1
  user_class.active = true
  user_class.save!
  puts "Created user class: #{class_data[:hero_class_id.name]} for user #{user_class.user.username}"
end

puts "#{UserClass.all.count} user classes created."

QuestCategory.destroy_all
puts "Deleted all quest categories."

# Create quest categories
categories = [
  { name: 'Cardio', category_xp: 10, hero_class_id: 1 },
  { name: 'Upper Body', category_xp: 12, hero_class_id: 1 },
  { name: 'Lower Body', category_xp: 10, hero_class_id: 1 },
  { name: 'Full Body', category_xp: 15, hero_class_id: 1 },
  { name: 'Meditation', category_xp: 8, hero_class_id: 2 },
  { name: 'Yoga', category_xp: 9, hero_class_id: 2 },
  { name: 'Breathwork', category_xp: 7, hero_class_id: 2 },
  { name: 'Journaling', category_xp: 5, hero_class_id: 3 },
  { name: 'Gratitude', category_xp: 6, hero_class_id: 3 },
  { name: 'Emotional Check-in', category_xp: 4, hero_class_id: 3 }
]

categories.each do |category_data|
  category = QuestCategory.create!(category_data)
  puts "Created quest category: #{category.name} with XP: #{category.category_xp}"
end
puts "#{QuestCategory.all.count} quest categories created."

Quest.destroy_all
puts "Deleted all quests."

# Create quests - with frequency set to 3 for demo purposes and xp set manually based on category and frequency
QuestCategory.all.each do |quegory|
  Quest.create!(
    title: "#{quegory.name} Challenge",
    description: "Complete a task in the #{quegory.name} category.",
    xp_granted: quegory.category_xp * 3, # e.g., frequency 3 for demo
    quest_category: quegory,
    frequency: 3
  )
end

puts "#{Quest.all.count} quests created."

UserQuest.destroy_all
puts "Deleted all user quests."

# Assign quests to users
15.times do
 assigned_quest = UserQuest.create!(
    user: User.all.sample, # Assign a random user for demo purposes
    quest: Quest.all.sample, # Assign a random quest for demo purposes
    completed: false,
    completed_frequency: 0
  )
  puts "Assigned quest to user: #{assigned_quest.user.username}"
end

puts "#{UserQuest.all.count} user-quests created."
