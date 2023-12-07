class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show]

  def index
    @articles = Article.all
    @featured_articles = @articles.sample(3)
    @opposing_articles = @articles.sample(3)

    @new_bookmark = Bookmark.new
    # @article_leaning = article_leaning

    sort_option = params[:sort]
    @latest_articles = @articles.order(created_at: :desc).to_a
    @latest_articles.sort_by!(&:leaning).reverse! if sort_option == 'right'
    @latest_articles.sort_by!(&:leaning) if sort_option == 'left'
  end

  def show
    @articles = Article.all
    @article.votes.any? ? @article_votes = @article.votes.size : @article_votes = 0
    @article.comments.any? ? @article_comments = @article.comments.size : @article_comments = 0
    @related_articles = @articles.sample(2)
    @opposing_articles = @articles.sample(2)
    @new_vote = Vote.new
    @article.photo_url.present? ? @photo_url = @article.photo_url : @photo_url = "https://ichef.bbci.co.uk/news/976/cpsprodpb/0376/production/_131768800_84891ceead1dacb05d4125eb505e830de51c45cb.jpg"
    @user_vote = @article.votes.where(user_id: current_user.id)
    @new_comment = Comment.new
    @new_bookmark = Bookmark.new
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

  def search
    if params[:query].present?
      @results = Article.search_by_title_and_content(params[:query])
      # raise
    else
      @results = Article.none
    end

    respond_to do |format|
      format.html { render 'search' } # Add this line for HTML format
      format.json { render partial: 'search_results', locals: { results: @results } }
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
