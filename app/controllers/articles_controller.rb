class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    @articles_categories = Article.select(:category).distinct
  end

  def create
    @article = Article.new(article_params)
    @articles_categories = Article.select(:category).distinct
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to article_path(@article.id)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    @articles_categories = Article.select(:category).distinct
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Article has been updated"
      redirect_to article_path
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id]).destroy
    flash[:info] = "Article deleted"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:name, :text, :category, :order)
  end
end
