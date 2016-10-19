class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource

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
      flash[:success] = t('article_created')
      redirect_to article_path(@article.id)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    @articles_categories = Article.select(:category).distinct
    @article_name = @article.reload.name
  end

  def update
    @article = Article.find(params[:id])
    @articles_categories = Article.select(:category).distinct
    @article_name = @article.reload.name
    if @article.update_attributes(article_params)
      flash[:success] = t('article_updated')
      redirect_to article_path
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id]).destroy
    flash[:info] = t('article_deleted')
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:name, :text, :category, :order)
  end
end
