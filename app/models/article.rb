class Article < ApplicationRecord
  has_many :comments
  has_many :bookmarks
  has_many :votes
end
