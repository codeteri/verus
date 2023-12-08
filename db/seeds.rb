require 'open-uri'
require 'json'
require 'faker'
require_relative './raw_articles'

puts "Cleaning up database..."
Article.destroy_all
def url_valid?(url)
  response = HTTParty.get(url)
  response.code == 200
rescue StandardError
  false
end

puts "Database cleaned"

puts "Creating articles..."

ARTICLE_DATA['articles']['results'].first(100).each do |article|
  author = article['authors'][0] ? article['authors'][0]['name'] : "Unknown"

  next unless url_valid?(article['image'])


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



10.times do
  User.create(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.unique.username,
    password: '123456',
    password_confirmation: '123456'
  )
end

puts "10 more Users created"

users = User.all
articles = Article.all

puts "Creating Bookmarks"

users.each do |user|
  4.times do
    # Select a random article
    article = Article.all.sample
    # p article.title
    unless article.bookmarked?(user)
      Bookmark.create!(
        # Create a bookmark
        user_id: user.id,
        article_id: article.id
      )
    end
  end
end

puts "Bookmarks created"
article = Article.find_by(title: "Israel and U.S. at odds over conflicting visions for postwar Gaza")

comments = [
  { content: "I believe the US's approach to not allowing Israel to reoccupy Gaza is prudent. It's essential to find a peaceful solution that respects the rights of all parties involved.", user: User.all.sample },
  { content: "It's a complex situation, but Israel's right to defend itself should be non-negotiable. The attacks from Hamas are unacceptable, and strong measures are needed.", user: User.all.sample },
  { content: "The humanitarian crisis in Gaza is deeply concerning. The international community must intervene to provide aid and support a peaceful resolution.", user: User.all.sample },
  { content: "Peace talks have failed repeatedly. It's time for a different approach. Maybe a stronger stance against Hamas will finally bring stability to the region.", user: User.all.sample },
  { content: "Blaming one side entirely oversimplifies the issue. Both parties have made mistakes, and both need to make compromises for peace.", user: User.all.sample },
  { content: "The death toll, especially among women and children, is heart-wrenching. We need to prioritize human lives over political agendas.", user: User.all.sample },
  { content: "As long as Hamas remains in power, peace talks seem futile. Their history and actions speak volumes about their intentions.", user: User.all.sample },
  { content: "It's about time the world recognizes the complexity of the situation. Simplistic solutions won't work. We need a nuanced approach that considers all aspects.", user: User.all.sample }
]

# Seed comments
comments.each do |comment_data|
  comment = Comment.new(comment_data)
  comment.article = article
  likes = (1..100).to_a
  dislikes = (1..15).to_a
  comment.likes = likes.sample
  comment.dislikes = dislikes.sample
  comment.save!
end

article = Article.find_by(title: "Trump is back at his New York civil fraud trial as testimony nears an end")
comments = [
  { content: "This trial is crucial. It's about holding powerful figures accountable, regardless of their political standing. The rule of law must be upheld.", user: User.all.sample },
  { content: "I'm skeptical about the timing and motives behind this lawsuit. It feels like a politically driven attack rather than a pursuit of justice.", user: User.all.sample },
  { content: "Transparency in financial dealings is non-negotiable, especially for public figures. If there's wrongdoing, it should be brought to light.", user: User.all.sample },
  { content: "The media seems to be jumping to conclusions before the trial is even over. Let's wait for all the facts before passing judgment.", user: User.all.sample },
  { content: "It's disheartening to see politics play such a heavy hand in legal matters. This trial should be about facts, not political affiliation.", user: User.all.sample },
  { content: "This trial sets a precedent. If someone can manipulate financial statements without repercussions, what message does that send?", user: User.all.sample },
  { content: "We've seen this pattern before - powerful individuals using their influence to sidestep legal consequences. Justice needs to be served.", user: User.all.sample },
  { content: "It seems like another attempt to discredit a political figure. We should question the motivations behind this trial and the evidence presented.", user: User.all.sample }
]

comments.each do |comment_data|
  comment = Comment.new(comment_data)
  comment.article = article
  likes = (1..100).to_a
  dislikes = (1..9).to_a
  comment.likes = likes.sample
  comment.dislikes = dislikes.sample
  comment.save!
end

article = Article.find_by(title: "In 2024 elections, we have to act against AI-aggravated bias")
comments = [
  { content: "The impact of AI on elections is a double-edged sword. While it can enhance engagement, the risks of misinformation and deep fakes are alarming.", user: User.all.sample },
  { content: "AI's role in elections is overhyped. Traditional campaigning and grassroots movements still hold the real power.", user: User.all.sample },
  { content: "The lack of diversity in AI development is a ticking time bomb. It's not just a tech issue, but a profound social challenge.", user: User.all.sample },
  { content: "We need stringent regulations for AI in elections. Without oversight, this technology could undermine the very fabric of our democracy.", user: User.all.sample },
  { content: "AI could revolutionize fair reporting, but only if we address biases in its programming. Otherwise, we risk entrenching existing prejudices.", user: User.all.sample }
]

comments.each do |comment_data|
  comment = Comment.new(comment_data)
  comment.article = article
  likes = (1..100).to_a
  dislikes = (1..9).to_a
  comment.likes = likes.sample
  comment.dislikes = dislikes.sample
  comment.save!
end

puts "#{Comment.count} Comments created"

puts "creating votes"

articles = Article.all

users.each do |user|
  articles.each do |article|
    # Assuming you have a range of possible values for votes, adjust as needed
    value = rand(1..5)

    # Create a vote
    Vote.create!(
      user: user,
      article: article,
      value: value
    )
  end
end


puts "#{Vote.count} votes created"


