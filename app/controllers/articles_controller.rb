class ArticlesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html

  expose(:article)
  expose(:articles) { |scope| scope.includes(:user).order(created_at: :desc) }

  def create
    article = current_user.articles.build(article_params)
    flash[:notice] = 'Article was successfully created.' if article.save
    respond_with(article)
  end

  def update
    article.update(article_params) if article.user == current_user
    redirect_to :root, notice: 'Article was successfully updated.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
