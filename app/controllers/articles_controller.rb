class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show article_leaning]

  def index
    @articles = Article.all
    @featured_articles = @articles.first(3)
    @opposing_articles = @articles.sample(3)
    @latest_articles = @articles.last(6)
  end

  def show
    @articles = Article.all
    @article.votes.any? ? @article_votes = @article.votes.size : @article_votes = 0
    @article.comments.any? ? @article_comments = @article.comments.size : @article_comments = 0
    @related_articles = @articles.sample(2)
    @opposing_articles = @articles.sample(2)

    # adding votes needs work:
    @new_vote = Vote.new

    # refactoring to un-n+1 ?? :
    @date = @article.date
    @author = @article.author
    @title = @article.title
    @content = @article.content
    @source = @article.source
  end

  def article_leaning
    # tb
    @all_votes = @article.votes
    @votes_sum = @all_votes.sum
    @leaning = @votes_sum.fdiv(@all_votes.size).round(0)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html { redirect_to articles_path }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:author, :date, :title, :content, :source, :photo_url)
  end
end
