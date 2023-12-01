class CommentsController < ApplicationController
  before_action :set_article, only: :create

  def create
    @new_comment = Comment.new(comment_params)
    @new_comment.article = @article
    @new_comment.user = current_user
    if @new_comment.save
      redirect_to article_path(@comment.article)
    else
      render 'new'
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :article_id)
  end
end
