

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

# Create user classes
classes = [
  { class_type: 'Warrior', xp: 0, level: 1 },
  { class_type: 'Healer', xp: 0, level: 1 },
  { class_type: 'Monk', xp: 0, level: 1 },
  { class_type: 'Warrior', xp: 0, level: 1 }
]

user_id = User.first.id # Start from the first user ID
classes.each do |class_data|
  user_class = UserClass.new(class_data)
  user_class.user = User.find(user_id)
  user_id += 1
  user_class.active = true
  user_class.save!
  puts "Created user class: #{class_data[:class_type]} for user #{user_class.user.username}"
end

puts "#{UserClass.all.count} user classes created."

QuestCategory.destroy_all
puts "Deleted all quest categories."

# Create quest categories
categories = [
  { name: 'Cardio', category_xp: 10, class_type: 'Warrior' },
  { name: 'Upper Body', category_xp: 12, class_type: 'Warrior' },
  { name: 'Lower Body', category_xp: 10, class_type: 'Warrior' },
  { name: 'Full Body', category_xp: 15, class_type: 'Warrior' },
  { name: 'Meditation', category_xp: 8, class_type: 'Monk' },
  { name: 'Yoga', category_xp: 9, class_type: 'Monk' },
  { name: 'Breathwork', category_xp: 7, class_type: 'Monk' },
  { name: 'Journaling', category_xp: 5, class_type: 'Healer' },
  { name: 'Gratitude', category_xp: 6, class_type: 'Healer' },
  { name: 'Emotional Check-in', category_xp: 4, class_type: 'Healer' }
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
