class VotesController < ApplicationController
  before_action :set_article, only: :create

  def create
    @new_vote = Vote.new(vote_params)
    @new_vote.article = @article
    @new_vote.user = current_user
    if @new_vote.save
      redirect_to article_path(@article, anchor: "anchor"), notice: "Thank you for voting!"
    else
      redirect_to article_path(@article), notice: "Something went wrong"
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def vote_params
    params.require(:vote).permit(:value, :user_id, :article_id)
  end
end
