class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  respond_to :html

  expose(:user_comments) { current_user.comments }
  expose(:article)
  expose(:comment, attributes: :comment_attributes, ancestor: :user_comments)

  def index
  end

  def create
    comment.save
    respond_with article
  end

  private

  def comment_attributes
    params.require(:comment).permit(:text).merge(article_id: article.id)
  end
end
