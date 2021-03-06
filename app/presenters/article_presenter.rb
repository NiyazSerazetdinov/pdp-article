class ArticlePresenter < BasePresenter
  attr_reader :article
  delegate :id, :user, :comments, :title, :text, :updated_at, :created_at, to: :article

  def initialize(article)
    @article = article
  end

  def updated?
    updated_at != created_at
  end

  def publication_info
    "#{create_date} #{by_user}"
  end

  def short_text
    simple_format(text.truncate(400, separator: ' '))
  end

  def formated_title
    title.titleize
  end

  def formated_text
    simple_format(text)
  end

  def comment_presenters
    CommentPresenter.wrap(comments.order(created_at: :desc))
  end

  def update_date
    t 'app.updated', date: DatePresenter.wrap(updated_at).human_date
  end

  private

  def create_date
    t 'app.created', date: DatePresenter.wrap(created_at).human_date
  end

  def by_user
    "by #{user.to_s.titleize}"
  end
end
