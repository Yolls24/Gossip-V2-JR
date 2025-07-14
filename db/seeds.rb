require 'faker'

# Création de 10 villes
10.times do
  City.create!(name: Faker::Address.city)
end

# Création de 10 utilisateurs associés à une ville existante
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    email:      Faker::Internet.email,
    age:        rand(18..65),
    city:       City.all.sample,  # Ici on donne une instance City, pas un string
    password:   "password",       # Ajout du password pour passer la validation has_secure_password
    password_confirmation: "password"
  )
end

# Création de 20 potins liés aux utilisateurs
20.times do
  Gossip.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph,
    user: User.all.sample
  )
end

puts "📌 Création des tags..."

10.times do
  Tag.create!(
    title: Faker::ProgrammingLanguage.unique.name.downcase
  )
end

puts "✅ #{Tag.count} tags créés avec succès."

