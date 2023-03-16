

class ArticlesController < ApplicationController
  def index
    @articles = Article.all

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @articles }
    end
  end

  def show
    @article = Article.find(params[:id])
  end 

  def new 
    @article = Article.new 
  end 

  def create 
    @article = Article.new(article_params)
    if @article.save 
      redirect_to @article
    else 
      render :new, status: :unprocessable_entity 
    end
  end 

  private 
    def article_params 
       params.require(:article).permit(:title, :body)
    end
end