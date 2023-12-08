class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @view = params[:view] || 'bookmarked'
    bookmarked_articles
    commented_articles
    respond_to do |format|
      format.html do
        if request.headers["Turbo-Frame"]
          render partial: "pages/#{@view}", layout: false
        else
          render :show
        end
      end
    end
  end

  def bookmarked_articles
    @bookmarked_articles = Article.joins(:bookmarks).where(bookmarks: { user_id: current_user.id })
  end

  def commented_articles
    @commented_articles = Article.joins(:comments).where(comments: { user_id: current_user.id })
  end




  # def bookmarked_articles
  #   @bookmarked_articles = []
  #   @all_bookmarks = current_user.bookmarks
  #   @all_bookmarks.each do |bookmark|
  #     @bookmarked_articles << Article.select(bookmark_id: bookmark.id)
  #   end
  # end
end
