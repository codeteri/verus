class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @new_comment = Comment.new(comment_params)
    @new_comment.article = @article
    @new_comment.user = current_user
    if @new_comment.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    @comment = Comment.find(params[:comment_id])
    # if @comment.update(comment_params)
      # redirect_back(fallback_location: root_path, notice: 'Listing was successfully updated.')
    # else
      # render :edit
    # end
  end

  def add_like
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
