class ArticlePresenter < BasePresenter
  delegate :id, :user, :title, :text, :updated_at, :created_at, to: :@article

  def initialize(article)
    @article = article
  end

  def updated?
    updated_at != created_at
  end

  def by_user
    user.to_s.titleize
  end

  def short_text
    text.truncate(250, separator: ' ')
  end

  def formated_title
    title.to_s.titleize
  end

  def updated
    I18n.t "app.article.updated", date: DatePresenter.wrap(updated_at).human_date
  end

  def created
    I18n.t "app.article.created", date: DatePresenter.wrap(created_at).human_date
  end
end
