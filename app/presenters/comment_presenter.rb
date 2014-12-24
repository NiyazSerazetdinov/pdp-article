class CommentPresenter < BasePresenter
  attr_reader :comment
  delegate :id, :user, :article, :text, :created_at, to: :comment

  def initialize(comment)
    @comment = comment
  end

  def by_user
    " by #{user.to_s.titleize}"
  end

  def created_date
    I18n.t 'app.article.created', date: DatePresenter.wrap(created_at).human_date
  end
end
