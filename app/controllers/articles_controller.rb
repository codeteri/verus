class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def create
	# fetch and create the articles and put them in an array
	@article = Article.new
	# //<————-Fetch Articles————->//
  end


end
