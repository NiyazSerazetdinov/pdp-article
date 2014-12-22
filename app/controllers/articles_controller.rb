class ArticlesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html

  expose(:article, attributes: :article_attributes)
  expose(:articles) { |scope| scope.includes(:user).order(created_at: :desc) }

  expose(:article_presenter) { ArticlePresenter.new(article) }
  expose(:article_presenters) { ArticlePresenter.wrap(articles) }

  def create
    article = current_user.articles.build(article_attributes)
    if article.save
      redirect_to article, notice: "Successfully created article."
    else
      render :new
    end
  end

  def update
    article.update(article_attributes) if article.user == current_user
    if article.save
      redirect_to article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  private

  def article_attributes
    params.require(:article).permit(:title, :text)
  end
end
