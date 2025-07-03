require 'faker'

10.times do
  city = Faker::Address.city
  City.create!(name: city)
end

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    email:      Faker::Internet.email,
    age:        rand(18..65),
    city:       City.all.sample.name
  )
end

20.times do
  Gossip.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph,
    user: User.all.sample
  )
end
