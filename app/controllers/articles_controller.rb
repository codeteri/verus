class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show]

  def index
    @articles = Article.all
    @featured_articles = @articles.first(3)
    @opposing_articles = @articles.sample(3)
    @latest_articles = @articles.last(6)
  end

  def show
    @article.votes.any? ? @article_votes = @article.votes.size : @article_votes = 0
    @article.comments.any? ? @article_comments = @article.comments.size : @article_comments = 0
    # @date = @article.date
    # @author = @article.author
    # @title = @article.title
    # @content = @article.content
    # @source = @article.source
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:author, :date, :title, :content, :source)
  end
end
