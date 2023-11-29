class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :author, presence: true
  validates :source, presence: true
  validates :content, presence: true, length: { minimum: 1000 }
end
