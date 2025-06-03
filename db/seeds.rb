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

User.delete_all!
puts "Deleted all users."

users = [
  { username: "kaashir", first_name: 'Mrinal', last_name: 'Verma', email: 'mrinalverma1993@gmail.com', password: '123123', address: 'The Hague', date_birth: "22/07/1993"},
  { username: "fratboi12", first_name: 'Thomas', last_name: 'Bruins', email: 'thomas.bruins12@gmail.com', password: '123123', address: 'Amsterdam', date_birth: "16/06/2006"},
  { username: "travelingdev", first_name: 'Carlijn', last_name: 'Driessen', email: 'carlijndriessen.dev@gmail.com', password: '123123', address: 'Limburg', date_birth: "7/11/1994"},
  { username: "dawikir", first_name: 'Daniel', last_name: 'Suarez', email: 'ndanielmnv@gmail.com', password: '123123', address: 'Rotterdam', date_birth: "23/07/1990"}
]

users.each do |user_data|
  User.create!(user_data)
  puts "Created user: #{user_data[:first_name]}"
end

puts "#{User.all.count} users created."

# Create user classes
classes = [
  { class_type: 'Warrior', xp: 0, level: 1 },
  { class_type: 'Healer', xp: 0, level: 1 },
  { class_type: 'Monk', xp: 0, level: 1 },
  { class_type: 'Warrior', xp: 0, level: 1 }
]

classes.each do |class_data|
  UserClass.create!(class_data)
  UserClass.user = User.all.sample # Assign a random user to each class
  puts "Created user class: #{class_data[:class_type]}"
end

puts "#{UserClass.all.count} user classes created."

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
