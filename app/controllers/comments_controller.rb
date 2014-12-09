class CommentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html

  expose(:article)
  expose(:comment)
  expose(:comments) { |scope| scope.order(created_at: :desc) }

  def create
    comment = article.comments.build(comment_params)
    comment.user = current_user
    respond_with(article)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
