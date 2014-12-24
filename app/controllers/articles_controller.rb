class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :index
  respond_to :html

  expose(:user_articles) { current_user.articles }
  expose(:article, attributes: :article_attributes, ancestor: :user_articles)
  expose(:articles) { |scope| scope.includes(:user).order(created_at: :desc) }

  expose(:article_presenter) { ArticlePresenter.wrap(article) }
  expose(:article_presenters) { ArticlePresenter.wrap(articles) }

  def create
    article.save
    respond_with article, status: :created, notice: 'Successfully created article.'
  end

  def update
    article.save
    respond_with article, notice: 'Article was successfully updated.'
  end

  private

  def article_attributes
    params.require(:article).permit(:title, :text)
  end
end
