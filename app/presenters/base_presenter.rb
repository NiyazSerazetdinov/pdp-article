class BasePresenter
  include ActionView::Helpers::TranslationHelper
  include ActionView::Helpers::TextHelper

  def self.wrap(object)
    if object.respond_to?(:map)
      object.map { |el| new(el) }
    else
      new(object)
    end
  end
end
