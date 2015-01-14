class CommentPresenter < BasePresenter
  attr_reader :comment
  delegate :id, :user, :article, :text, :created_at, to: :comment

  def initialize(comment)
    @comment = comment
  end

  def comment_info
    "#{create_date} #{by_user}"
  end

  private

  def by_user
    "by #{user.to_s.titleize}"
  end

  def create_date
    t 'app.created', date: DatePresenter.wrap(created_at).human_date
  end
end
