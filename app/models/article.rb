class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :user, :text, presence: true
  validates :title,
            presence: true,
            length: {
              maximum: 60
            },
            uniqueness: {
              case_sensitive: false
            }
end
