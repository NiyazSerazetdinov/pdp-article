class Article < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :text
  validates :title,
    presence: true,
    length: {
      maximum: 60
    },
    uniqueness: {
      case_sensitive: false
    }
end
