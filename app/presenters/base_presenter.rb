class BasePresenter
  include ActionView::Helpers::TranslationHelper

  def self.wrap(object)
    if object.respond_to?(:map)
      object.map { |el| new(el) }
    else
      new(object)
    end
  end
end
