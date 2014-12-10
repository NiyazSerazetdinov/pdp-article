class CommentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html

  expose(:article)
  expose(:comment)
  expose(:comments) { |scope| scope.order(created_at: :desc) }

  def create
    comment = comments.new(comment_params)
    comment.save
    respond_with(article)
  end

  private

  def comment_params
    params.require(:comment)
          .permit(:user_id, :text, :article_id)
          .merge(user_id: current_user.id, article_id: article.id)
  end
end
