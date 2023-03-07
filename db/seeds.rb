puts "🌱 Seeding movies..."

10.times do
    Movie.create!(
      title: Faker::Movie.title,
      year: rand(2000..2023),
      description: Faker::Lorem.paragraph(sentence_count: 5),
      user_id: rand(1..20),
      fetched_first: Faker::Boolean.boolean
    )
  end
  

  10.times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password(min_length: 6)
    )
  end
  

puts "✅ Done seeding!"