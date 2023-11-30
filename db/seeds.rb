puts "creating articles..."
10.times do
  Article.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    title: Faker::Book.title,
    source: Faker::Internet.url,
    date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    created_at: Faker::Date.between(from: 2.days.ago, to: Date.today),
    updated_at: Faker::Date.between(from: 1.days.ago, to: Date.today),
    content: Faker::Lorem.paragraph_by_chars(number: 2000, supplemental: false)
  )
end

puts "creating Users..."
10.times do
  User.create(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.unique.username,
    password: '123456',
    password_confirmation: '123456'
  )
end

users = User.all
articles = Article.all
# Create some comments
puts "adding comments..."
50.times do
  Comment.create(
    content: Faker::Lorem.sentence(word_count: 5),
    user: users.sample,
    article: articles.sample
  )
end

# puts "creating users..."
# alice = User.create!(username: "Alice", email: "alice@example.com", password: "12345678")
# bob = User.create!(username: "Bob", email: "bob@example.com", password: "12345678")
# charlie = User.create!(username: "Charlie", email: "charlie@example.com", password: "12345678")
# ramon = User.create!(username: "Ramon", email: "ramon@example.com", password: "12345678")

# puts "Users created"
