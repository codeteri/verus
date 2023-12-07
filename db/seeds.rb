require 'open-uri'
require 'json'
require 'faker'

puts "Cleaning up database..."
Article.destroy_all
puts "Database cleaned"

puts "Creating articles..."

# Call the API and put each article inside an Article model
keywords = [
  "InternationalRelations",
  "Elections",
  "GovernmentPolicies",
  "GlobalAffairs",
  "GovernmentPolicies",
]

api_key = ENV['NEWS_API_KEY']

query = {
  '$query': {
    '$or': keywords.map { |keyword| { 'keyword': keyword } },
    '$and': [{ 'lang': 'eng' }]
  }
}

url = "https://eventregistry.org/api/v1/article/getArticles?query=#{URI.encode_www_form_component(JSON.generate(query))}&apiKey=#{api_key}&includeArticleAuthors=true&includeArticleImage=true"

response = JSON.parse(URI.open(url).read)


response['articles']['results'].first(50).each do |article|
  author = article['authors'][0] ? article['authors'][0]['name'] : "Unknown"

  if article['image'].present?
    Article.create!(
      title: article['title'],
      author: author ,
      photo_url: article['image'],
      source: article['source']['uri'],
      date: article['date'],
      content: article['body'],
      created_at: Faker::Date.between(from: 2.days.ago, to: Date.today),
      updated_at: Faker::Date.between(from: 1.days.ago, to: Date.today),
    )
  end
end

puts "Articles created"

User.create(email:"bob@example.com", username: "bobby", password: "123456", password_confirmation: '123456')
puts "User Bob Created"

# 10.times do
#   User.create(
#     email: Faker::Internet.unique.email,
#     username: Faker::Internet.unique.username,
#     password: '123456',
#     password_confirmation: '123456'
#   )
# end
# puts "Users created"
# users = User.all
# articles = Article.all


# # Create some comments
# puts "adding comments..."
# 50.times do
#   Comment.create(
#     content: Faker::Lorem.sentence(word_count: 5),
#     user: users.sample,
#     article: articles.sample
#   )
# end
