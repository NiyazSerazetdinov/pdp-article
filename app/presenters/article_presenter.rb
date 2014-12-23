class ArticlePresenter < BasePresenter
  attr_reader :article
  delegate :id, :user, :title, :text, :updated_at, :created_at, to: :article

  def initialize(article)
    @article = article
  end

  def updated?
    updated_at != created_at
  end

  def by_user
    " by #{user.to_s.titleize}"
  end

  def created_by?(some_user)
    user == some_user
  end

  def short_text
    text.truncate(250, separator: ' ')
  end

  def formated_title
    title.titleize
  end

  def updated_date
    I18n.t "app.article.updated", date: DatePresenter.wrap(updated_at).human_date
  end

  def created_date
    I18n.t "app.article.created", date: DatePresenter.wrap(created_at).human_date
  end
end
