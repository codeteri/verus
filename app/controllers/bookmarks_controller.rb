class BookmarksController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @new_bookmark = Bookmark.new(article: @article, user: current_user)

    respond_to do |format|
      if @new_bookmark.save
        # raise
        saved(format)
      else
        not_saved(format)
      end
    end
  end

  private

  def saved(format)
    target_path = params[:origin] == "show" ? @article : root_path
    format.html { redirect_to target_path, notice: 'Article was successfully bookmarked.' }
    format.turbo_stream
  end

  def not_saved(format)
    target_path = params[:origin] == "show" ? @article : root_path
    format.html { redirect_to target_path, alert: "Couldn't save bookmark, please try again" }
    format.turbo_stream
  end

  def bookmark_params
    params.require(:bookmark).permit(:article_id)
  end
end
