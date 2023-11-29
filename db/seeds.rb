# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
10.times do
  Article.create(
    author: Faker::Book.author,
    title: Faker::Book.title,
    source: Faker::Internet.url,
    content: Faker::Lorem.paragraph,
    date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    created_at: Faker::Date.between(from: 2.days.ago, to: Date.today),
    updated_at: Faker::Date.between(from: 1.days.ago, to: Date.today)
  )
end

# puts "creating users..."
# alice = User.create!(username: "Alice", email: "alice@example.com", password: "12345678")
# bob = User.create!(username: "Bob", email: "bob@example.com", password: "12345678")
# charlie = User.create!(username: "Charlie", email: "charlie@example.com", password: "12345678")
# ramon = User.create!(username: "Ramon", email: "ramon@example.com", password: "12345678")

# puts "Users created"
